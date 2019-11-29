
import {getRank} from "../../utils/api";

Page({
    data: {
      page:0,
      rank:null,
      total:0,
      bigHour:0,
      smallHour:0,
      bigMinute:0,
      smallMinute:0,
      colors:[
        '#7CFC00', '#32CD32', '#00EEEE', '#B23AEE', '#CD00CD', '#EE0000'
      ]
    },

    onLoad: function () {

    },

    onShow: function () {
        this.countTime()
        this.countDown()
        this.loadRank()
    },

    goToIndex: function (e) {
        let index = e.currentTarget.dataset.index
        let id = this.data.rank[index].id
        qq.setStorageSync("community",this.data.rank[index])
        qq.navigateTo({
            url: '../index/index?id=' + id
        })
    },
    //获取排名
    loadRank: function () {
        let self = this
        getRank({},this.data.page).then( res => {
            if(res.data.code == 1 && res.data.obj){
                let rank = res.data.obj.corps
                Object.keys(rank).forEach( item => {
                    Object.keys(rank[item].corpLabels).forEach( i => {
                        rank[item].corpLabels[i].color = self.randomColor()
                    })
                })
                console.log(rank)
                self.setData({
                    rank:rank,
                    total:res.data.obj.allCount
                })
            }
        })
    },

    //倒计时
    countDown: function () {
        let self = this
        let inter = setInterval(() => {
            self.countTime()
        }, 1000 * 60)
    },

    countTime: function () {
        let self = this
        let curDate = new Date();
        let nextDate = new Date(curDate.getTime() + 24*60*60*1000)

        let startTime = nextDate.getFullYear() + "/" + ((nextDate.getMonth() + 1) < 10 ? "0" + (nextDate.getMonth() + 1):(nextDate.getMonth() + 1))+ "/" + (nextDate.getDate() < 10 ? "0" + nextDate.getDate():nextDate.getDate());
        let newDate = new Date(startTime + " 00:00:00");
        let endTime = newDate.getTime()
        let nowTime = curDate.getTime()
        let leftTime = parseInt((endTime - nowTime)/1000)
        let hour = parseInt((leftTime%86400)/3600)
        let minute = parseInt((leftTime%3600)/60)
        self.setData({
            bigHour: hour > 10 ? parseInt(hour/10) : 0,
            smallHour: hour < 10 ? hour :parseInt(hour%10),
            bigMinute:minute > 10 ? parseInt(minute/10) : 0,
            smallMinute:minute < 10 ? minute :parseInt(minute%10),
        })
    },
    //随机字符颜色
    randomColor: function () {
        let random = Math.random(0,1).toFixed(2)
        let color;
        switch (true) {
            case random>=0 && random<0.07:
                color = '#ffcccc'
                break;
            case random>=0.07 && random<0.14:
                color = '#ffe6cc'
                break;
            case random>=0.14 && random<0.2:
                color = '#ffffcc'
                break;
            case random>=0.2 && random<0.4:
                color = '#e6ffcc'
                break;
            case random>=0.4 && random<0.6:
                color = "#ccffcc"
                break;
            case random>=0.6 && random<0.8:
                color = '#ccffe6'
                break;
            case random>=0.8 && random<0.87:
                color = '#ccffff'
                break;
            case random>=0.87 && random<0.94:
                color = '#cce5ff'
                break;
            case random>=0.94 && random<1:
                color = '#ccccff'
                break;
        }
        return color
    }
})
