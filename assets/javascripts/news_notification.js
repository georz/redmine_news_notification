(function() {
    var cnt = news.length;

    var classes = new Array();
    classes['nn_badge_bgc'] = 'nn_badge_bgc';
    classes['nn_badge_cnt'] = 'nn_badge_cnt';

    var nn_list = '<ul>';

    if (cnt > 0) {
        if (cnt > 99) {
            cnt = '!!';
        }
        classes['nn_badge_bgc'] = '';
        classes['nn_badge_cnt'] = '';

        for (var i = 0; i < news.length; i ++) {
            nn_list += '<li><a href="/news/' + news[i][0] + '">';
            nn_list += '<div class="nn_prtl">' + news[i][5] + ': ' + news[i][1] + '</div>';
            nn_list += '<div class="summary">' + news[i][2] + '</div>';
            nn_list += '<div class="nn_info">' + news[i][3] + ' | ' + news[i][4] + '</div>';
            nn_list += '</a></li>';
        }
    } else {
        nn_list += '<li><a class="nn_none">No unread news.</a></li>';
    }
    nn_list += '</ul>';

    var nn = document.querySelector('.nn');
    nn.innerHTML = '<span id="nn_badge"><span id="nn_badge_bgc" class="' + classes['nn_badge_bgc'] + '"></span><span id="nn_badge_cnt" class="' + classes['nn_badge_cnt'] + '">' + cnt + '</span></span>';
    nn.insertAdjacentHTML('afterend', '<div id="nn_list_box" style="visibility: hidden;"><div id="nn_header"><a href="/news">View all news</a></div><div id="nn_list">' + nn_list + '</div></div>');

    var nn_list_box = document.getElementById('nn_list_box');

    nn.addEventListener('click', function(e) {
        e.preventDefault();
        if (nn_list_box.style.visibility === 'hidden') {
            nn_list_box.style.visibility = 'visible';
            document.addEventListener('click', nn_hidden, false);
        } else {
            nn_hidden(e, true);
        }
    }, false);

    function nn_hidden(e, flag) {
        if (is_nn(e.target) && flag !== true) {
            return false;
        }
        nn_list_box.style.visibility = 'hidden';
        document.removeEventListener('click', nn_hidden);
    }

    function is_nn(elm) {
        while (elm = elm.parentNode) {
            if (elm.id === 'nn_list_box' || elm.id === 'nn_badge') {
                return true;
            }
        }
        return false;
    }
})();