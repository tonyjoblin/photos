// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

var input, preview;

function setup() {
  input = document.querySelector('#photo_image');
  preview = document.querySelector('.preview');

  // hide the file input
  input.style.opacity = 0; 

  input.addEventListener('change', updateImageDisplay);
}

function clearPreviewList() {
  while(preview.firstChild) {
    preview.removeChild(preview.firstChild);
  }
}

function setPreviewListIsEmpty() {
  var para = document.createElement('p');
  para.textContent = 'No photos are currently selected for upload';
  preview.appendChild(para);
}

const fileTypes = [
  'image/jpeg',
  'image/gif',
  'image/png'
];

function validFileType(file) {
  for(var i = 0; i < fileTypes.length; i++) {
    if(file.type === fileTypes[i]) {
      return true;
    }
  }
  return false;
}

function returnFileSize(file) {
  const number = file.size;
  if(number < 1024) {
    return number + 'bytes';
  } else if(number > 1024 && number < 1048576) {
    return (number/1024).toFixed(1) + 'KB';
  } else if(number > 1048576) {
    return (number/1048576).toFixed(1) + 'MB';
  }
}

function getPhotoPreviewText(file) {
  return "File name " + file.name + ", file size " + returnFileSize(file) + ".";
}

function getInvalidFileText(file) {
  return 'File name ' + curFiles[i].name + ': Not a valid file type. Update your selection.';
}

function getListItemParaText(func) {
  var listItem = document.createElement('li');
  var para = document.createElement('p');
  para.textContent = func();
  listItem.appendChild(para);
  return listItem;
}

function getPreviewForFile(file) {
  if (validFileType(file)) {
    return getListItemParaText(function() { return getPhotoPreviewText(file); });
  } else {
    return getListItemParaText(function(){ return getInvalidFileText(file); });
  }
}

function addPhotosToPreviewList() {
  var list = document.createElement('ol');
  preview.appendChild(list);
  var curFiles = input.files;
  for(var i = 0; i < curFiles.length; i++) {
    var file = curFiles[i];
    var listItem = getPreviewForFile(file);
    if (listItem) {
      list.appendChild(listItem);
    }
  }
}

function createPreviewList() {
  var curFiles = input.files;
  if (curFiles.length === 0) {
    setPreviewListIsEmpty();
  } else {
    addPhotosToPreviewList();
  }
}

function updateImageDisplay() {
  clearPreviewList();
  createPreviewList();
}

window.addEventListener("load", setup);