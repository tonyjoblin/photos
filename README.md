# My Photo Album

## About

Started as a 1-hour of code each day project.

Originally looking at file uploads as an exercise, because that was what I was working on at work. Beyond that it will be a learning tool for rails, javascript and css.

## TODO

Error handling around file upload and storage.
Make url a property on photo model rather than calculate it each time
Sanitise user input for photo caption and story.
Positioning of add photo button
Responsive layout for index page
Paging on photo index page
Testing photos controller create action
Page to display detail of individual photo
Validate maximum number of photos uploaded.
Validate maximum image sizes.
Deleting photo
Adding captions to photos
Allow tags on photos.
Add optional description to photos.
Detecting duplicate photo uploads
AI to automatically detect contents of photo and tag photos
Allow maximum limit on backend storage used. Enforce through front and backend validations.
Likes

## Done

Story text, preserving format and markup.
Change app title from Files to something else
Changed index page layout so scroll bars are on side of page not side of main content inset from sides.
Use partial to render photo card
Layout photos in grid
Display list of photos on photo#index page
Handle uploading more than one photo
Backend validate mime types.
Make photo index the default landing page
Put add photo button on photo#index page
Create photo needs to create uploads folder if it does not exist.
Added Tests for Photo model class.
Added validation to enforce presence of photo name and file name.
Database migration to make photo names not null.
