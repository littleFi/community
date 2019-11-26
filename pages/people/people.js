//content.js
//获取应用实例
const app = getApp()

import {people, mine, label, updateHeadImg, updateNickName} from '../../utils/api'
import tip from '../../utils/tip'

Page({
    data: {
        headImg:null,
        nickName:null,
        corpId:5,
        people:null, //个人扩展信息
        mine:null,    //个人信息
        auth:false,
        label:null
    },
    onLoad: function () {
        let nickName = qq.getStorageSync("nickname");
        let headImg = qq.getStorageSync("headImg");
        if(nickName && headImg){
            this.setData({
                headImg:headImg,
                nickName:nickName,
                auth:true
            })
            this.people()
            this.mine()
        }

    },
    //个人扩展信息
    people: function () {
        let params = {}
        let self = this
        people(params).then( res => {
            let data = res.data.obj
            self.setData({
                people:data
            })
        },err => {
            tip.toast(err.msg)
        })
    },

    //获取个人标签
    getLabel:function(userId) {
        let self = this
        label({},userId).then( res => {
            let data = res.data.obj
            let label = null
            if(data.length > 0){
                for (let i=0;i < data.length; i++){
                    if(data[i].type == 1){
                        label = data[i].label
                        break
                    }
                }
                for (let i=0;i < data.length; i++){
                    if(data[i].type == 0){
                        label = data[i].label
                        break
                    }
                }
            }
            self.setData({
                label:label
            })
        })
    },

    mine: function () {
        let params = {}
        let self = this
        mine(params).then( res => {
            let data = res.data.obj;
            self.setData({
                mine:data
            })
            if(data){
                let userId = data.userId
                self.getLabel(userId)
            }

        },err => {
            tip.toast(err.msg)
        })
    },

    goToMine:function () {
        qq.navigateTo({
            url: '../mine/mine'
        })
    },

    //授权
    auth: function(e) {
        let info = e.detail.userInfo
        qq.setStorageSync("nickname",info['nickName'])
        qq.setStorageSync("headImg",info['avatarUrl'])
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
            auth:true
        })
        this.people()
        this.mine()
    },

    //分享
    onShareAppMessage: function() {
        return {
            'title':'雅言社区',
            'path': '/pages/home/home'
        }
    }
})
