import 'tinymce/tinymce';
import 'tinymce/themes/silver';
import 'tinymce/plugins/paste';
import 'tinymce/plugins/link';
import 'tinymce/plugins/image';
// Добавьте любые другие плагины, которые вы хотите использовать

document.addEventListener("DOMContentLoaded", () => {
    tinymce.init({
        selector: "textarea.tinymce",
        plugins: "paste link image",
        toolbar: "undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image"
        // Добавьте любые другие настройки, необходимые для вашего проекта
    });
});
