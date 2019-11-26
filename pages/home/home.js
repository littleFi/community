
import {
    updateHeadImg,
    updateNickName,
    mine,
    home
} from '../../utils/api'
import tip from '../../utils/tip'

Page({
  data: {
      auth:true,
      home:null,
      month:null,
      day:null,
      week:null
  },
    //社区中心
    center: function () {
    qq.navigateTo({
      url: '../center/center'
    })
  },

    //社区榜
    rank: function() {
      qq.navigateTo({
          url: '../community/community'
      })
  },

    onShow: function () {
        let nickName = qq.getStorageSync("nickname");
        let headImg = qq.getStorageSync("headImg");
        let token = qq.getStorageSync("token");
        let schoolId = qq.getStorageSync("schoolId")
        if(token){
            this.setData({
                auth:false
            })

        }
        if(!schoolId){
            this.getMine()
        }
        if(nickName && headImg){
            this.setData({
                headImg:headImg,
                nickName:nickName
            })
        }
        this.getHome()
        this.getTime()
      },
    //分享
    onShareAppMessage: function() {
          return {
              'title':'社区',
              'path': '/pages/home/home'
          }
      },

    //授权
    auth: function(e) {
          let info = e.detail.userInfo
          qq.setStorageSync("nickname",info['nickName'])
          qq.setStorageSync("headImg",info['avatarUrl'])
            console.log(info['avatarUrl'])
          let params = {
              query:{
                  "headUrl": info['avatarUrl']
              },
              method: "POST"
          }
          updateHeadImg(params).then( res => {

          })
          updateNickName({},info['nickName']).then( res => {

          })
          this.setData({
              headImg:info['avatarUrl'],
              nickName:info['nickName'],
              auth:false
          })
      },

    //获取个人全部信息
    getMine: function () {
        let params= {}
        mine(params).then(res => {
            let data = res.data.obj;
            if(data){
                qq.setStorageSync("schoolId",data.schoolId)
            }
        },err => {
            tip.toast(err.msg)
        })
    },

    //首页信息
    getHome: function () {
        let params = {}
        let self = this
        home(params).then( res => {
            if(res.data.code == 1){
                self.setData({
                    home:res.data.obj
                })
            }
        })
    },

    //获取当前时间
    getTime: function () {
        let date = new Date();
        let month = date.getMonth()+1
        let day = date.getDate()
        let week = "日一二三四五六".charAt(date.getDay());
        this.setData({
            month:month,
            day:day,
            week:week
        })
    }
})
