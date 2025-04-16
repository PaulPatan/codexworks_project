// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails';
import 'controllers';
import 'channels';
import { Application } from '@hotwired/stimulus';
import SpaNavigationController from './controllers/spa_navigation_controller.js';

window.Stimulus = Application.start();
Stimulus.register('spa-navigation', SpaNavigationController);
