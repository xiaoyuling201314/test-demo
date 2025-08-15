(function ($) {

    $.fn.softkeys = function(options) {

        var settings = $.extend({
                layout : [],
                target : '',
                notice : '',
                rowSeperator : 'br',
                buttonWrapper : 'li',
            },  options);

        var createRow = function(obj, buttons) {
        	
                for (var i = 0; i < buttons.length; i++) {
                    createButton(obj, buttons[i]);
                }

                obj.append('<'+settings.rowSeperator+'>');
            },

            createButton = function(obj, button) {
                var character = '',
                    type = 'letter',
                    styleClass = '';

                switch(typeof button) {
                    case 'array' :
                case 'object' :
                        if(typeof button[0] !== 'undefined') {
                            character += '<span>'+button[0]+'</span>';
                        }
                        if(typeof button[1] !== 'undefined') {
                            character += '<span>'+button[1]+'</span>';
                        }
                        type = 'symbol';
                        break;

                    case 'string' :
                        switch(button) {
                            case 'capslock' :
                                character = '<span>caps</span>';
                                type = 'capslock';
                                break;

                            case 'shift' :
                                character = '<span>shift</span>';
                                type = 'shift';
                                break;

                            case 'return' :
                                character = '<span>return</span>';
                                type = 'return';
                                break;

                            case 'tab' :
                                character = '<span>tab</span>';
                                type = 'tab';
                                break;

                            case 'space' :
                                character = '<span>space</span>';
                                type = 'space';
                                styleClass = 'softkeys__btn--space';
                                break;

                            case 'delete' :
                                character = '删除';
                                type = 'delete';
                                break;

                            case 'close' :
                                character = '×';
                                type= 'close'
                                break;
                            case '-' :
                                character = '<span class="m-key">-</span>';
                                type= 'symbol'
                                break;
                            case '_' :
                                character = '<span class="m-key">_</span>';
                                type= 'symbol'
                                break;
                            default :
                                character = button;
                                type = 'letter';
                                break;
                        }

                        break;
                }

                obj.append('<'+settings.buttonWrapper+' class="softkeys__btn'+styleClass+'" data-type="'+type+'">'+character+'</'+settings.buttonWrapper+'>');
                
            },

            bindKeyPress = function(obj) {
                obj.children(settings.buttonWrapper).on('click touchstart', function(event){
                    event.preventDefault();
                    var character = '',
                        type = $(this).data('type'),
                        targetValue = $(settings.target).val();

                    switch(type) {
                        case 'capslock' :
                            toggleCase(obj);
                            break;

                        case 'shift' :
                            toggleCase(obj);
                            toggleAlt(obj);
                            break;

                        case 'return' :
                            character = '\n';
                            break;

                        case 'tab' :
                            character = '\t';
                            break;
                        case '-' :
                            character = '-';
                            break;
                        case '_' :
                            character = '_';
                            break;
                        case 'space' :
                            character = ' ';
                            break;
                        case 'close' :
                            $('.softkeys').hide();
                        break;
                        case 'delete' :
                            targetValue = targetValue.substr(0, targetValue.length - 1);
                            break;

                        case 'symbol' :
                            if(obj.hasClass('softkeys--alt')) {
                                character = $(this).children('span').eq(1).html();
                            } else {
                                character = $(this).children('span').eq(0).html();
                            }
                            break;

                        case 'letter' :
                            character = $(this).html();

                            if(obj.hasClass('softkeys--caps')) {
                                character = character.toUpperCase();
                            }

                            break;
                    }

                    $(settings.target).focus().val(targetValue + character);
                    if(character!=''){
                    	fireKeyEvent($(settings.target)[0],"keyup",character.charCodeAt());
                    }else{
                    	fireKeyEvent($(settings.target)[0],"keyup",8);
                    }
                });
            },

            toggleCase = function(obj) {
                obj.toggleClass('softkeys--caps');
            },

            toggleAlt = function(obj) {
                obj.toggleClass('softkeys--alt');
            };

        return this.each(function(){
            console.log("doing")
            
            for (var i = 0; i < settings.layout.length; i++) {
            	if(i == 0){
            		$(this).html('<div class="notice">'+settings.notice+'</div>');
            	}
            	
                createRow($(this), settings.layout[i]);
            }
            //console.log(settings.layout)
            bindKeyPress($(this));
            
        });
        
    };

}(jQuery));
function fireKeyEvent(el, evtType, keyCode){  
    var doc = el.ownerDocument,  
        win = doc.defaultView || doc.parentWindow,  
        evtObj;  
    if(doc.createEvent){  
        if(win.KeyEvent) {  
            evtObj = doc.createEvent('KeyEvents');  
            evtObj.initKeyEvent( evtType, true, true, win, false, false, false, false, keyCode, 0 );  
        }  
        else {  
            evtObj = doc.createEvent('UIEvents');  
            Object.defineProperty(evtObj, 'keyCode', {  
                get : function() { return this.keyCodeVal; }  
            });       
            Object.defineProperty(evtObj, 'which', {  
                get : function() { return this.keyCodeVal; }  
            });  
            evtObj.initUIEvent( evtType, true, true, win, 1 );  
            evtObj.keyCodeVal = keyCode;  
            if (evtObj.keyCode !== keyCode) {  
                console.log("keyCode " + evtObj.keyCode + " 和 (" + evtObj.which + ") 不匹配");  
            }  
        }  
        el.dispatchEvent(evtObj);  
    }   
    else if(doc.createEventObject){  
        evtObj = doc.createEventObject();  
        evtObj.keyCode = keyCode;  
        el.fireEvent('on' + evtType, evtObj);  
    }  
} 