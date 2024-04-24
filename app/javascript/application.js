// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import * as bootstrap from "bootstrap"
import Rails from "@rails/ujs"

document.addEventListener('DOMContentLoaded', function() {
    tinymce.init({
        selector: 'textarea.tinymce',
        plugins: 'autolink lists link',
        toolbar: 'undo redo | formatselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link',
        menubar: false,
        setup: function(editor) {
            editor.on('keyup', function() {
                updateMarkdownPreview(editor.getContent());
            });
        }
    });
});

Rails.start()
