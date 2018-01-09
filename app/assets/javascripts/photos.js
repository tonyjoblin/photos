// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

var input, preview;

function setup() {
  input = document.querySelector('input');
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
  para.textContent = 'No files currently selected for upload';
  preview.appendChild(para);
}

function validFileType(file) {
  return true;
}

function getFileSize(file) {
  return "0kb";
}

function getFilePreviewText(file) {
  return "File name " + file.name + ", file size " + getFileSize(file) + ".";
}

function getPreviewForPhoto(file) {
  var listItem = document.createElement('li');
  var para = document.createElement('p');
  para.textContent = getFilePreviewText(file);
  listItem.appendChild(para);
  return listItem;
}

function getPreviewForFile(file) {
  if (validFileType(file)) {
    return getPreviewForPhoto(file);
  } else {
    return null;
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