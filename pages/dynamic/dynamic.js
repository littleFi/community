const app = getApp()
import tip from '../../utils/tip'
import {getAllDynamic,dynamicComment,dynamicLike,replyComment} from "../../utils/api";

Page({
    data: {
        corpId:5,
        dynamic:null,
        page:0
    },

    onLoad: function () {
        this.getDynamic()
    },
    //社团动态列表
    getDynamic:function() {
        let params= {};
        let corpId = this.data.corpId;
        let self = this
        getAllDynamic(params,this.data.page).then( res => {
            if(res.data.code == 1){
                let dynamic = res.data.obj
                // Object.keys(dynamic).forEach( item => {
                //     dynamic[item].timestamp = this.timeDiff(dynamic[item].time)
                // })
                self.setData({
                    dynamic:dynamic
                })
            }
        })
    },

    timeDiff: function(timestamp) {
        let minute = 1000 * 60;      //把分，时，天，周，半个月，一个月用毫秒表示
        let hour = minute * 60;
        let day = hour * 24;
        let week = day * 7;
        let halfamonth = day * 15;
        let month = day * 30;
        let result;
        let now = new Date().getTime();   //获取当前时间毫秒
        let diffValue = now - dateTimeStamp;//时间差
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
    },
    detail: function (e) {
        let id = e.currentTarget.dataset.id
        qq.navigateTo({
            url: '../detail/detail?id='+id
        })
    },
    //点赞
    praise: function (e) {
        let index = e.currentTarget.dataset.index
        let params = {}
        let id = this.data.dynamic[index].id
        dynamicLike(params,id).then( res => {
            if(res.data.code == 1){
                tip.toast("点赞成功",function(){},'none')
            }else{
                tip.toast("取消点赞",function(){},'none')
            }
        })
    },

    //发表动态
    goToPublish: function (e) {
        qq.navigateTo({
            url: '../publish/publish'
        })
    }
})
