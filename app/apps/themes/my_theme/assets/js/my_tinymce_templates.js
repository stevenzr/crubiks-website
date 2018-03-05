jQuery(function(){
    tinymce_global_settings["settings"].push(my_custom_function);
});
function my_custom_function(custom_settings, def_settings){
    def_settings['templates'] = def_settings['templates'] || [];
    def_settings['templates'].push({title: 'Simple Template', description: 'This is a simple template', content: '<div class="mceTmpl"><h1>Title Template</h1><div>body template</div></div>'});
}