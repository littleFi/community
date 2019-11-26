const formatTime = date => {
  const year = date.getFullYear()
  const month = date.getMonth() + 1
  const day = date.getDate()
  const hour = date.getHours()
  const minute = date.getMinutes()
  const second = date.getSeconds()

  return [year, month, day].map(formatNumber).join('/') + ' ' + [hour, minute, second].map(formatNumber).join(':')
}

const formatNumber = n => {
  n = n.toString()
  return n[1] ? n : '0' + n
}

const timeDiff = timestamp => {
    let minute = 1000 * 60;      //把分，时，天，周，半个月，一个月用毫秒表示
    let hour = minute * 60;
    let day = hour * 24;
    let week = day * 7;
    let halfamonth = day * 15;
    let month = day * 30;
    let result;
    let now = new Date().getTime();   //获取当前时间毫秒
    let diffValue = now - timestamp;//时间差
    if(diffValue < 0){
        return '刚刚';
    }
    let minC = diffValue/minute;  //计算时间差的分，时，天，周，月
    let hourC = diffValue/hour;
    let dayC = diffValue/day;
    let weekC = diffValue/week;
    let monthC = diffValue/month;
    if(monthC >= 1 && monthC <= 3){
        result = " " + parseInt(monthC) + "月前"
    }else if(weekC >= 1 && weekC <= 3){
        result = " " + parseInt(weekC) + "周前"
    }else if(dayC >= 1 && dayC <= 6){
        result = " " + parseInt(dayC) + "天前"
    }else if(hourC >= 1 && hourC <= 23){
        result = " " + parseInt(hourC) + "小时前"
    }else if(minC >= 1 && minC <= 59){
        result =" " + parseInt(minC) + "分钟前"
    }else if(diffValue >= 0 && diffValue <= minute){
        result = "刚刚"
    }else {
        var datetime = new Date();
        datetime.setTime(dateTimeStamp);
        var Nyear = datetime.getFullYear();
        var Nmonth = datetime.getMonth() + 1 < 10 ? "0" + (datetime.getMonth() + 1) : datetime.getMonth() + 1;
        var Ndate = datetime.getDate() < 10 ? "0" + datetime.getDate() : datetime.getDate();
        var Nhour = datetime.getHours() < 10 ? "0" + datetime.getHours() : datetime.getHours();
        var Nminute = datetime.getMinutes() < 10 ? "0" + datetime.getMinutes() : datetime.getMinutes();
        var Nsecond = datetime.getSeconds() < 10 ? "0" + datetime.getSeconds() : datetime.getSeconds();
        result = Nyear + "-" + Nmonth + "-" + Ndate
    }
    return result;
}
module.exports = {
    formatTime: formatTime,
    timeDiff: timeDiff
}