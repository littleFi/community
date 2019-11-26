//content.js
//获取应用实例
const app = getApp()

import {publish,getPeopleCorp} from '../../utils/api'
import tip from '../../utils/tip'

Page({
    data: {
        images:[],
        content:null,
        corpList:null,
        page:0
    },
    onLoad: function () {
        this.getCorpList()
    },

    //获取社团列表
    getCorpList: function () {
        let self = this
        let params = {}

        getPeopleCorp(params,this.data.page).then( res => {
            let data = res.data.obj
            self.setData({
                corpList:data
            })
        },err => {

        })
    },

    //选择
    choose: function (e) {
        let index = e.currentTarget.dataset.index
        let corporation = this.data.corpList[index]
        qq.setStorageSync("corporation",corporation)
        qq.redirectTo({
            url: '../publish/publish'
        })
    }
})
