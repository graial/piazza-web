// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import Bridge__ElementController from "./bridge/element_controller"
application.register("bridge--element", Bridge__ElementController)

import NavbarController from "./navbar_controller"
application.register("navbar", NavbarController)

import RemoveElementController from "./remove_element_controller"
application.register("remove-element", RemoveElementController)

import TagsController from "./tags_controller"
application.register("tags", TagsController)
