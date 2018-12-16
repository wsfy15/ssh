function formatDateYMD(date) {
    var y = date.getFullYear();
    var m = date.getMonth() + 1;
    m = m < 10 ? ('0' + m) : m;
    var d = date.getDate();
    d = d < 10 ? ('0' + d) : d;
    var str = y + '年' + m + '月' + d + '日';
    return str;
}

function formatDateYMDhms(date) {
    var Y = date.getFullYear();
    var M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1);
    var D = date.getDate();
    var h = (date.getHours() < 10 ? '0' + date.getHours() : date.getHours()) + ':';
    var m = (date.getMinutes() < 10 ? '0' + date.getMinutes(): date.getMinutes())+ ':';
    var s = (date.getSeconds() < 10 ? '0' + date.getSeconds(): date.getSeconds());
    return (Y + '年'+ M + '月' + D + '日 ' + h + m + s);
}