// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"
import Tagify from '@yaireo/tagify'

// Initialize Tagify on the input field
const input = document.getElementById('ingredients-input');
if (input) {
    new Tagify(input);
}
