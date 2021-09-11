# Readme

This repo demonstrates a technique for dynamically rendering content from the server into a modal, processing form submissions on the server, and updating the DOM aftwards without a full page turn. We do this with Ruby on Rails, Mrujs, and CableReady, with Stimulus and Tailwind powering the modal.

This repo accompanies the tutorial article originally published on [my blog](https://www.colby.so/posts/modal-forms-with-cableready-and-mrujs).

# Project setup

Clone this repo to your local machine and then:

```
bundle
rails db:create db:migrate
bin/dev
```

Once your server is started, head to /customers to view the application in action.
