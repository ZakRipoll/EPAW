DROP DATABASE IF EXISTS trwita;

CREATE DATABASE trwita;

USE trwita;

CREATE TABLE users(
	user CHAR(24),
	name CHAR(50) NOT NULL,
	middleName CHAR(50),
	lastName CHAR(50) NOT NULL,
	mail CHAR(50) NOT NULL,
	password CHAR(50) NOT NULL,
	birthdate DATE,
	profilePicture CHAR(200),
	follow TINYINT UNSIGNED DEFAULT 0,
	followed TINYINT UNSIGNED DEFAULT 0,
	tweets TINYINT UNSIGNED DEFAULT 0,
	PRIMARY KEY (user)
);

CREATE TABLE follow(
	user1 CHAR(24) NOT NULL,
	user2 CHAR(24) NOT NULL,
	PRIMARY KEY (user1, user2),
	FOREIGN KEY (user1) REFERENCES users (user),
	FOREIGN KEY (user2) REFERENCES users (user)
);

CREATE TABLE tweets(
	id SMALLINT UNSIGNED AUTO_INCREMENT,
	user CHAR(24) NOT NULL,
	text CHAR(140) NOT NULL,
	date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	likes TINYINT UNSIGNED DEFAULT 0,
	retweets TINYINT UNSIGNED DEFAULT 0,
	shares TINYINT UNSIGNED DEFAULT 0,
	PRIMARY KEY (id),
	FOREIGN KEY (user) REFERENCES users (user) ON DELETE CASCADE
);

CREATE TABLE lrc(
	tweetid SMALLINT UNSIGNED,
	user CHAR(24),
	love BOOLEAN DEFAULT FALSE,
	retweet SMALLINT UNSIGNED DEFAULT 0,
	comment SMALLINT UNSIGNED DEFAULT 0,
	PRIMARY KEY (user, tweetid),
	FOREIGN KEY (user) REFERENCES users (user) ON DELETE CASCADE,
	FOREIGN KEY (tweetid) REFERENCES tweets (id) ON DELETE CASCADE
);


CREATE TABLE admin(
	user CHAR(24),
	PRIMARY KEY (user),
	FOREIGN KEY (user) REFERENCES users (user) ON DELETE CASCADE
);

DELIMITER //

/************************************************************************ TRIGGERS ************************************************************************/

DROP TRIGGER IF EXISTS newTweet; //
DROP TRIGGER IF EXISTS deleteTweet; //
DROP TRIGGER IF EXISTS newFollow; //
DROP TRIGGER IF EXISTS deleteFollow; //
DROP TRIGGER IF EXISTS newUser; //
DROP TRIGGER IF EXISTS newLRC; //
DROP TRIGGER IF EXISTS updateLRC;//
DROP TRIGGER IF EXISTS deleteLRC;//

CREATE TRIGGER newTweet AFTER INSERT ON tweets
FOR EACH ROW
BEGIN
	UPDATE users SET tweets = tweets + 1 WHERE user LIKE NEW.user;
END; //

CREATE TRIGGER deleteTweet BEFORE DELETE ON tweets
FOR EACH ROW
BEGIN
	UPDATE users SET tweets = tweets - 1 WHERE user LIKE OLD.user;
END; //

CREATE TRIGGER newFollow AFTER INSERT ON follow
FOR EACH ROW
BEGIN
	IF( NEW.user1 <> NEW.user2 ) THEN
		UPDATE users SET follow = follow + 1 WHERE user LIKE NEW.user1;
		UPDATE users SET followed = followed + 1 WHERE user LIKE NEW.user2;
	END IF;
END; //

CREATE TRIGGER deleteFollow BEFORE DELETE ON follow
FOR EACH ROW
BEGIN
	IF( OLD.user1 <> OLD.user2 ) THEN
		UPDATE users SET follow = follow - 1 WHERE user LIKE OLD.user1;
		UPDATE users SET followed = followed - 1 WHERE user LIKE OLD.user2;
	END IF;
END; //

CREATE TRIGGER newUser AFTER INSERT ON users
FOR EACH ROW
BEGIN	
	INSERT INTO follow VALUES(NEW.user, NEW.user);
END;//

CREATE TRIGGER newLRC AFTER INSERT ON lrc
FOR EACH ROW
BEGIN
	IF (NEW.retweet > 0) THEN
		UPDATE tweets SET retweets = retweets + 1 WHERE id LIKE NEW.tweetid;
	ELSEIF(NEW.love = TRUE) THEN
		UPDATE tweets SET likes = likes + 1 WHERE id LIKE NEW.tweetid;
	ELSE
		UPDATE tweets SET shares = shares + 1 WHERE id LIKE NEW.tweetid;
	END IF;
END;//

CREATE TRIGGER updateLRC AFTER UPDATE ON lrc
FOR EACH ROW
BEGIN
	IF(NEW.retweet <> OLD.retweet) THEN
		IF(NEW.retweet = 0) THEN
			UPDATE tweets SET retweets = retweets - 1 WHERE id = NEW.tweetid;
		ELSE
			UPDATE tweets SET retweets = retweets + 1 WHERE id = NEW.tweetid;
		END IF;
	ELSEIF (NEW.love <> OLD.love) THEN
		IF(NEW.love <> TRUE) THEN
			UPDATE tweets SET likes = likes - 1 WHERE id = NEW.tweetid;
		ELSE
			UPDATE tweets SET likes = likes + 1 WHERE id = NEW.tweetid;
		END IF;
	ELSEIF (NEW.comment <> OLD.comment) THEN
		IF(NEW.comment = 0) THEN
			UPDATE tweets SET shares = shares - 1 WHERE id = NEW.tweetid;
		ELSE
			UPDATE tweets SET shares = shares + 1 WHERE id = NEW.tweetid;
		END IF;
	END IF;	
END;//

CREATE TRIGGER deleteLRC BEFORE DELETE ON lrc
FOR EACH ROW
BEGIN
	IF (OLD.love = TRUE) THEN
		UPDATE tweets SET likes = likes - 1 WHERE id = OLD.tweetid;
	END IF;
END;//

/************************************************************************ PROCEDURES ************************************************************************/
DROP PROCEDURE IF EXISTS updateORinsertLRC;//
DROP PROCEDURE IF EXISTS deleteTweet; //
DROP PROCEDURE IF EXISTS deleteAllTweets; //
DROP PROCEDURE IF EXISTS deleteUser; //

CREATE PROCEDURE updateORinsertLRC( _tweetid TINYINT UNSIGNED, _user CHAR(24), _field bit )
BEGIN
	DECLARE _isIn TINYINT UNSIGNED UNSIGNED;
	DECLARE _isFriend TINYINT UNSIGNED UNSIGNED;
	DECLARE _id TINYINT UNSIGNED UNSIGNED;
	DECLARE _text CHAR(140);
	DECLARE _insert TINYINT UNSIGNED UNSIGNED;
	SET _isFriend = (SELECT COUNT(*) FROM follow WHERE user1 LIKE _user AND user2 LIKE (SELECT user FROM tweets WHERE id = _tweetid) AND user1 NOT LIKE user2);
	IF(_isFriend = 1) THEN
		SET _isIn = (SELECT COUNT(*) FROM lrc WHERE tweetid = _tweetid AND user LIKE _user);
		IF(_field = FALSE) THEN 
			IF(_isIn = 1) THEN
				UPDATE lrc SET love = !love WHERE tweetid = _tweetid AND user LIKE _user;
			ELSE
				INSERT INTO lrc (tweetid, user, love) VALUES(_tweetid, _user, TRUE);
			END IF;
		ELSE
			IF(_isIn = 1) THEN
				IF(_field = TRUE) THEN
					SET _insert = (SELECT retweet FROM lrc WHERE tweetid = _tweetid AND user LIKE _user);
					IF( _insert = 0 ) THEN
						SET _text = (SELECT text FROM tweets WHERE id = _tweetid);
						INSERT INTO tweets (user, text) VALUES( _user, _text);
					ELSE
						SET _id = (SELECT MAX(id) FROM tweets WHERE user LIKE _user);
						DELETE FROM tweets WHERE id = _id;
					END IF;
				ELSE
					SET _insert = (SELECT comment FROM lrc WHERE tweetid = _tweetid AND user LIKE _user);
					IF( _insert = 0 ) THEN
						SET _text = (SELECT text FROM tweets WHERE id = _tweetid);
						INSERT INTO tweets (user, text) VALUES( _user, _text);
					ELSE
						SET _id = (SELECT MAX(id) FROM tweets WHERE user LIKE _user);
						DELETE FROM tweets WHERE id = _id;
					END IF;
				END IF;
				SET _id = (SELECT MAX(id) FROM tweets WHERE user LIKE _user);
				IF(_field = TRUE) THEN
					UPDATE lrc SET retweet = CASE WHEN retweet = 0 THEN _id ELSE 0 END WHERE tweetid = _tweetid AND user LIKE _user;
				ELSE
					UPDATE lrc SET comment = CASE WHEN comment = 0 THEN _id ELSE 0 END WHERE tweetid = _tweetid AND user LIKE _user; 
				END IF;
			ELSE
				SET _text = (SELECT text FROM tweets WHERE id = _tweetid);
				INSERT INTO tweets (user, text) VALUES( _user, _text);
				SET _id = (SELECT MAX(id) FROM tweets WHERE user LIKE _user);
				IF(_field = TRUE) THEN
					INSERT INTO lrc (tweetid, user, retweet) VALUES(_tweetid, _user, _id);
				ELSE
					INSERT INTO lrc (tweetid, user, comment) VALUES(_tweetid, _user, _id);
				END IF;
			END IF;
		END IF;
	END IF;
END; //


CREATE PROCEDURE deleteTweet( _user CHAR(24), _tweetid TINYINT UNSIGNED,  _field bit )
BEGIN
	DECLARE _id TINYINT UNSIGNED;
	IF(_field = TRUE) THEN 
		SET _id = (SELECT tweetid FROM lrc WHERE user LIKE _user AND retweet = _tweetid);
	ELSE
		SET _id = (SELECT tweetid FROM lrc WHERE user LIKE _user AND comment = _tweetid);
	END IF;
	IF( _id IS NULL ) THEN
		DELETE FROM tweets WHERE id = _tweetid;
	ELSE
		CALL updateORinsertLRC( _id, _user, _field);
	END IF;
END; //

CREATE PROCEDURE deleteAllTweets( _user CHAR(24) ) 
BEGIN
	
	DECLARE _id TINYINT UNSIGNED UNSIGNED;
	
	DECLARE _end INT;
	
	DECLARE _ids CURSOR FOR SELECT id FROM tweets WHERE user LIKE _user;
	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET _end = 1;
	
	OPEN _ids;
	
		SET _end = 0;
		
		REPEAT
	
	    FETCH _ids INTO _id;
	 
	    	IF (!_end) THEN
		  		
	    		CALL deleteTweet( _user, _id, TRUE);
		  		CALL deleteTweet( _user, _id, FALSE);
		  		/*CALL deleteTweet( _user, _id, NULL);*/
		  		
		  	END IF;
		  	
		UNTIL _end END REPEAT;
		
	 CLOSE _ids;
	 
	 DELETE FROM lrc WHERE user LIKE _user;
	 
END; //

CREATE PROCEDURE deleteUser( _user CHAR(24) )
BEGIN
	CALL deleteAllTweets(_user);
	DELETE FROM follow WHERE user1 LIKE _user;
	DELETE FROM follow WHERE user2 LIKE _user;
	DELETE FROM users WHERE user LIKE _user; 
END; //

/********************************************************************* FUNCTIONS *********************************************************************/

DROP FUNCTION IF EXISTS friends; //

CREATE FUNCTION friends( _user1 CHAR(24), _user2 CHAR(24) ) RETURNS INTEGER
BEGIN

  RETURN ( SELECT COUNT(*) FROM follow WHERE user1 LIKE _user1 and user2 LIKE _user2 );

END; //

CREATE FUNCTION interaction( _tweetid TINYINT UNSIGNED, _user CHAR(24), _field bit ) RETURNS BOOL
BEGIN
	DECLARE _exists BOOL;
	SET _exists = 0;
	IF(_field = TRUE) THEN 
  		SET _exists = (SELECT 0 != love FROM lrc WHERE user LIKE _user and tweetid = _tweetid);
  	ELSEIF(_field = FALSE) THEN
  		SET _exists = (SELECT 0 != retweet FROM lrc WHERE user LIKE _user and tweetid = _tweetid);
  	ELSE
  		SET _exists = (SELECT 0 != comment FROM lrc WHERE user LIKE _user and tweetid = _tweetid);
  	END IF;
  	IF(_exists IS NULL) THEN
  		SET _exists = 0;
  	END IF;
  	RETURN _exists;
END; //

DELIMITER ;

/********************************************************************* VIEWS *********************************************************************/

DROP VIEW IF EXISTS tweetsView;

CREATE VIEW tweetsView AS
SELECT id, user, name, middleName, lastName, profilePicture, text, date, likes, retweets, shares 
FROM users NATURAL JOIN tweets;

/**************************************************************** DEFAULT INSERTS ****************************************************************/
INSERT INTO `users` (user, name, middleName, lastName, mail, password, birthdate, profilePicture)
VALUES ('admin','Admin', 'Van','Buuren','admin@gmail.com','Buuren','1976-12-25',
'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f0/Van_Buuren_2013_%28cropped%29.jpg/481px-Van_Buuren_2013_%28cropped%29.jpg'),
('Adriana','Adriana','Barrachina','Aznar','Adriana@gmail.com','123123','1992-09-26',''),
('aalbav','Alba','Villalón','Lucas','alba.villalon@gmail.com','123123','1992-01-07',''),
('alboca','Albert','Bové','Castellví','alboca@gmail.com','123456','1992-03-16',''),
('iZaac','Isaac','Rossell','Ripoll','isaac1842@gmail.com','123456','1992-01-22',
'https://pbs.twimg.com/profile_images/2644950496/1477183c8e57e181feaada9e90ef752c_400x400.jpeg'),
('nicoa','Nicolau','Duran','Silva','nico@gmail.com','123456','1994-02-13',''),
('Alena','Helena','Planas','Bahí','Helena.Planas@gmail.com','123456','1996-03-08',''),
('vcolodrero','Victor','Colodrero','Torrero','victor.colodrero@gmail.com','12345','1990-04-08','');

INSERT INTO `follow` VALUES('alboca', 'iZaac'), ('alboca', 'nicoa');

INSERT INTO `tweets` (user, text) VALUES('iZaac', 'Healthy Fruit Pizza with a Whole Grain, Flaxseed, Oatmeal Cookie Crust and Yogurt Frosting'),
('iZaac', 'El tweet de prova per borrar'), 
('admin', 'Can not wait to be back at @electrobeach! Who will I see there? https://tickets.electrobeacom #EMF2017');

INSERT INTO `admin` VALUES('admin'), ('iZaac');