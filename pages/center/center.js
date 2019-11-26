//content.js
//获取应用实例
import tip from "../../utils/tip";

const app = getApp()

import {
    getCommunity, people,
    school
} from '../../utils/api'

Page({
    data: {
        page:0,
        community:null,
        school:null,
        isSelected:true,
        schoolName:null,
        people:null,
        colors:[
            '#7CFC00', '#32CD32', '#00EEEE', '#B23AEE', '#CD00CD', '#EE0000'
        ]
    },

    goToIndex: function (e) {
        let index = e.currentTarget.dataset.index
        let id = this.data.community[index].id
        qq.setStorageSync("community",this.data.community[index])
        qq.navigateTo({
          url: '../index/index?id=' + id
        })
    },
    onLoad: function () {

    },

    onShow: function() {
        let schoolId = qq.getStorageSync("schoolId")
        let schoolName = qq.getStorageSync("schoolName")
        if(schoolName){
            this.setData({
                schoolName:schoolName
            })
        }
        this.loadSchool()
        if(schoolId){
            this.loadCommunity(schoolId)
        }
        this.people()
    },

    //获取所有社区
    loadCommunity: function (schoolId) {
        let params = {}
        let self = this

        getCommunity(params,this.data.page,schoolId).then( res => {
            if(res.data.code == 1){
                let data = res.data.obj;
                Object.keys(data).forEach( item => {
                    Object.keys(data[item].corpLabels).forEach( i => {
                        data[item].corpLabels[i].color = self.randomColor()
                    })
                })
                self.setData({
                    community:data
                })
            }
        },err => {

        })
    },

    //获取学校
    loadSchool : function () {
        let self = this
        school({}).then( res => {
            let data = res.data.obj;
            self.setData({
                school:data
            })
        })
    },

    //选择学校
    bindPickerChange(e) {
        let index = e.detail.value
        let schoolId = this.data.school[index].id
        let schoolName = this.data.school[index].name
        console.log(schoolName)
        qq.setStorageSync("schoolId",schoolId)
        qq.setStorageSync("schoolName",schoolName)
        this.setData({
            schoolName:schoolName
        })
        this.loadCommunity(schoolId)
    },

    //个人扩展信息
    people: function () {
        let params = {}
        let self = this
        people(params).then( res => {
            let data = res.data.obj;
            self.setData({
                people:data
            })
        },err => {
            tip.toast(err.msg)
        })
    },

    //随机字符颜色
    randomColor: function () {
        let random = Math.random(0,1).toFixed(2)
        let color;
        switch (random) {
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
