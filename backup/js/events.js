function fadeInFunction(){
  if (currentScene < 4){
    classes = document.body.getElementsByClassName('back')[0].classList
    classes.remove(
      'fadein','slide-0','slide-1','slide-2',
      'slide-3','slide-4','slide-5','slide-6'
    );
  }
}

function fadeOutFunction(){
  if (currentScene < 4){
    classes = document.body.getElementsByClassName('back')[0].classList
    classes.remove(
      'fadein','slide-0','slide-1','slide-2',
      'slide-3','slide-4','slide-5','slide-6'
    );
    if (currentAnimDirection != 'up'){
      classes.add('fadein','slide-'+parseInt(currentScene+1));
    } else {
      classes.add('fadein','slide-'+parseInt(currentScene));
    }
  }
}

function endAnimationCallback() {
//   console.log(camera.position, camera.rotation);
}

function onWindowResize() {
  windowHalfX = window.innerWidth / 2;
  windowHalfY = window.innerHeight / 2;
  camera.aspect = window.innerWidth / window.innerHeight;
  camera.updateProjectionMatrix();
  cameraCube.aspect = window.innerWidth / window.innerHeight;
  cameraCube.updateProjectionMatrix();
  renderer.setSize( window.innerWidth, window.innerHeight );
}

function onDocumentMouseMove(event) {
  // mouseY = ( event.clientY - window.innerHeight );
  mouseX = ( event.clientX - window.innerWidth );
  // console.log(mouseY);
}

function scrollFunction(way){

  // currentSceneChecker();

  if (currentScene == 0){
    if (way == 'down'){
      scene.position.z += 1;
    }else{
      scene.position.z -= 1;
    }
  }
  if (currentScene == 1){
    if (way == 'down'){
      scene.position.z += 0.3;
    }else{
      scene.position.z -= 0.3;
    }
  }
  if (currentScene == 2){
    if (way == 'down'){
      scene.position.x -= 1;
    }else{
      scene.position.x += 1;
    }
  }
  if (currentScene == 3){
    if (way == 'down'){
      scene.position.z -= 3;
      scene.position.y -= 1;
      scene.rotation.x += 0.0005;
    }else{
      scene.position.z += 3;
      scene.position.y += 1;
      scene.rotation.x -= 0.0005;
    }
  }
  if (currentScene == 4){
    if (way == 'down'){
      fadeOutFunction()
    }else{
    }
  }
}

var SCROLL = 0;
$(document).ready(function(){
  $(document).mousewheel(function(event){
    if (event.deltaY > 0) {
      if (!isAnim && currentScene > 0){
        currentAnimDirection = 'up';
        isAnim = true;
      }
    }else{
      if (!isAnim && currentScene < scenes.length-1){
        currentAnimDirection = 'down';
        isAnim = true;
      }
    }

    // console.log(SCROLL);
    // $('.back').css('opacity', SCROLL/100);
  });
});