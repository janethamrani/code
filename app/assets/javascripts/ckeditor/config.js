CKEDITOR.editorConfig = function(config) {
  config.language = 'en';
  config.width = '700';
  config.filebrowserBrowseUrl = "/ckeditor/attachment_files";
  config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures";
  config.filebrowserImageBrowseUrl = "/ckeditor/pictures";
  config.filebrowserImageUploadUrl = "/ckeditor/pictures";
  config.filebrowserUploadUrl = "/ckeditor/attachment_files";

  CKEDITOR.editorConfig = function (config) {
    config.plugins =
    'htmlSource,' +    //Here is the plugin
    'about,' +
    'a11yhelp,' +
    'basicstyles,' +
    'bidi,' +
    .....;

    plugInName = 'htmlSource';

    CKEDITOR.plugins.add(plugInName,
    {
      init: function (editor) {

        editor.addCommand('htmlDialog', new CKEDITOR.dialogCommand('htmlDialog'));
        editor.ui.addButton(plugInName, {
            label: 'Html Source',
            icon: 'http://www.example.com/images/btn_html.png',
            command: 'htmlDialog'
        });

        CKEDITOR.dialog.add('htmlDialog', function (editor) {
            return {
                title: 'Fuente Html',
                minWidth: 600,
                minHeight: 400,
                contents: [
                            {
                                id: 'general',
                                label: 'Settings',
                                elements:
                                [
                                // UI elements of the Settings tab.
                                    {
                                    type: 'textarea',
                                    id: 'contents',
                                    rows: 25,
                                    onShow: function () {
                                        this.setValue(editor.container.$.innerHTML);

                                    },
                                    commit: function (data) {              //--I get only the body part in case I paste a complete html
                                        data.contents = this.getValue().replace(/^[\S\s]*<body[^>]*?>/i, "").replace(/<\/body[\S\s]*$/i, "");
                                    }

                                }
                                    ]
                            }
                        ],

                onOk: function () {
                    var data = {};
                    this.commitContent(data);
                    $(editor.container.$).html(data.contents);
                },
                onCancel: function () {
                    //  console.log('Cancel');
                }
            };
        });
    }



config.toolbar = 'Full';   //Add the plugin to the full toolbar

config.toolbar_Full =      //Note that our plugin will be the first button in the toolbar
        [
        ['htmlSource'],
        '/',
        ['Bold', 'Italic', 'Underline', 'Strike', '-', 'Subscript', 'Superscript'],
        ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', 'Blockquote', 'CreateDiv'],
        ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'],
        ['Link', 'Unlink', 'Anchor'],
        ['Image', 'Flash', 'Table', 'HorizontalRule', 'Smiley', 'SpecialChar', 'PageBreak'],
        '/',
        ['Styles', 'Format', 'Font', 'FontSize'],
        ['TextColor', 'BGColor'],
        ['Maximize', 'ShowBlocks', '-', 'About']
   ];
};
