function showProfiles(element){

    $('#leftcolumnIndex').load('LoginController', {user: element.parentNode.id});
    $('#contentIndex').load('TweetsController', {user: element.parentNode.id, profile: 'profile'});
    
}
