//content.js
//获取应用实例
const app = getApp()

import tip from '../../utils/tip'
import {mine, setIntroduction} from "../../utils/api";

Page({
    data: {
      auth:true,
      headImg:null,
      nickName:null,
      corpId:5,
      mine:null,   //个人信息
      content:''
    },
    onLoad: function () {
      let nickName = qq.getStorageSync("nickname");
      let headImg = qq.getStorageSync("headImg");
        this.setData({
            headImg:headImg,
            nickName:nickName,
        })
        this.getMine()
    },

    //获取个人全部信息
    getMine: function () {
      let params= {}
      let self = this
      mine(params).then(res => {
        let data = res.data.obj;
        if(data){
            self.setData({
                mine:data,
                content:data.selfIntroduction
            })
        }
      },err => {
        tip.toast(err.msg)
      })
    },

    //更新个人简介
    updateIntroduction: function() {
        let params = {
            "selfIntroduction": this.data.content
        }
        setIntroduction(params).then( res => {
            tip.toast("编辑成功")
        },err => {

        })
    },

    //分享
    onShareAppMessage: function () {
        return {
            title: '雅言社区',
            path: '/pages/home/home'
        }
    }
})
