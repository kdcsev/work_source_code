var chatting_box_handler={
    init:function () {
        var self=this;
        self.set_scroll_height();
        self.bindEvents();
    },
    set_scroll_height:function () {
        var window_height=$(window).height();
        window_height=parseInt(window_height);
        var chatting_height=(1-0.25)*window_height;
        chatting_height=parseInt(chatting_height);
        //$("#app-wrapper").css({"height":chatting_height+"px"});
        var scroll_height=chatting_height-50;
        /*slim_scroll = $(".body--maximized").slimScroll({
            height:scroll_height+'px',
            alwaysVisible:false
        });
        $(".contact-body--maximized").slimScroll({
            height:chatting_height+'px',
            alwaysVisible:false
        });*/
        $(window).trigger('scroll');
    },
    load_current_user:function(guest_info){
        guest_id=guest_info.guest_id;
        currentUser={
            id: "",
            login: guest_info.guest_name+guest_info.guest_id,
            pass: "getappinstall",
            user_image:"http://192.168.0.72/000_work/higher_level_mlm/Source/assets/global/img/default-avatar.png"
        };
        this.initChatApp();
        $(".contact-info-container").addClass('hidden');
        $(".chat-container").removeClass('hidden');
    },
    initChatApp:function () {
        var options = {
            currentUser: currentUser
        };
        ChatApp.init(options);
    },
    resetForm: function(){
        var chatting_contact_form=$(".chatting-box-form");
        $(".chat-box-wrapper").find(".minimizeBtn").trigger("click");
    },
    bindEvents:function () {
        var self=this;
        var chatting_contact_form=$(".chatting-box-form");
        $("body").on("click","#maximumBtn",function () {
            var adv_id="";
            adv_id=parseInt(adv_id);
            if(adv_id>0){
                window.location.href="user/dashboard/index";
            }else{
                $("#maximumBtn").removeClass("has-unread-message");
                $("#app-wrapper").removeClass('hidden');
                $("#app-wrapper").removeClass("wrapper--hidden");
                $(".wrapper--bubble").removeClass("wrapper--hidden");
                $(this).closest(".chat-box-wrapper").removeClass("closed");
                $(this).closest(".chat-box-wrapper").addClass("opened");
                setTimeout(function () {
                    $("#app-wrapper").addClass("shadow");
                },300);
            }
        });
        $("body").on("click",".minimizeBtn",function () {
            $("#app-wrapper").addClass("wrapper--hidden");
            $(".wrapper--bubble").addClass("wrapper--hidden");
            $(this).closest(".chat-box-wrapper").removeClass("opened");
            $(this).closest(".chat-box-wrapper").addClass("closed");
            $("#app-wrapper").removeClass("shadow");
        });
    }
};
$(document).ready(function () {
    chatting_box_handler.init();
});

function openChatBox(flag){
    if(flag) {
        $(".chat-box-wrapper #maximumBtn").trigger("click");
    }else{
        $(".chat-box-wrapper .minimizeBtn").trigger("click");
    }
}
window.openChatBox = openChatBox;