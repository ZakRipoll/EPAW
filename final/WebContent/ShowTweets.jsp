<link href="css/showTweets.css" rel="stylesheet">

<script src="js/ShowTweets.js"></script>

<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:if test = "${write == 'yes'}">
	<textarea maxlength="140" id="newTweet" onkeydown="sendTweet(event, '${user}', '${profile}')"></textarea>
</c:if>

<c:forEach items="${tweets}" var="tweet">

    <div class = "container">
		<div class = "userInfomation">
			<div class = "profilePicture">
				<img class = "foto" alt="Profile Picture" src="${tweet.getProfilePicture()}">
			</div>
			<div class = "personalInformation">
				<div class = "tweetName"> ${tweet.getName()} ${tweet.getMiddleName()} ${tweet.getLastName()}</div>
				<div class = "userName" onclick="showProfile('${tweet.getUser()}', '${user}')"> @${tweet.getUser()} </div>
				<div class = "time"> ${tweet.getData()} 
					<c:if test = "${user == tweet.getUser() || admin != null}">
							<div class = "delete" onclick="tweetDelete(${tweet.getId()}, '${tweet.getUser()}')">
								<i class="material-icons">close</i>
							</div>
					</c:if>
				</div>
			</div>
			<div class = "tweet">
				${tweet.getText()}
			</div>
		</div>
		<div id = "${tweet.getId()}" class = "likeRetweetShare">
			<div class = "retweetContainer">
				<c:choose>
					<c:when test = "${write == 'yes' || user == null}" >
							<div class = "retweetIcon${tweet.isUserRetweet()}" onclick="likeRetweetShare(this, '${user}', '${profile}')"> <i class="material-icons">autorenew</i> </div> 
					</c:when>
					<c:otherwise>
							<div class = "retweetIcon${tweet.isUserRetweet()}" onclick="likeRetweetShare(this, '${tweet.getUser()}', '${profile}')"> <i class="material-icons">autorenew</i> </div>
		  			</c:otherwise>
				</c:choose>
				<div class = "retweet">${tweet.getRetweet()}</div> 
			</div>
			<div class = "likeContainer"> 
				<c:choose>
					<c:when test = "${write == 'yes' || user == null}" >
							<div class = "likeIcon${tweet.isUserLove()}" onclick="likeRetweetShare(this, '${user}', '${profile}')"> <i class="material-icons">favorite_border</i> </div> 
					</c:when>
					<c:otherwise>
							<div class = "likeIcon${tweet.isUserLove()}" onclick="likeRetweetShare(this, '${tweet.getUser()}', '${profile}')"> <i class="material-icons">favorite_border</i> </div>
		  			</c:otherwise>
				</c:choose>
				<div class = "like"> ${tweet.getLikes()}</div>
			</div>
			<div class = "shareContainer">
				<c:choose>
					<c:when test = "${write == 'yes' || user == null}" >
							<div class = "shareIcon${tweet.isUserComment()}" onclick="likeRetweetShare(this, '${user}', '${profile}')"> <i class="material-icons">send</i> </div> 
					</c:when>
					<c:otherwise>
							<div class = "shareIcon${tweet.isUserComment()}" onclick="likeRetweetShare(this, '${tweet.getUser()}', '${profile}')"> <i class="material-icons">send</i> </div>
		  			</c:otherwise>
				</c:choose>
				<div class = "share"> ${tweet.getShare()}</div>
			</div>	
		</div>
	</div>
	
</c:forEach>

<c:if test = "${fn:length(tweets) == 0}" >
	<div class = "container">
		<p> No tweets yet </p>
	</div>
</c:if>
