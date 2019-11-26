//content.js
//获取应用实例
const app = getApp()

import tip from '../../utils/tip'
import {dynamicDetail, getDynamicComment, dynamicComment, replyComment, dynamicLike} from "../../utils/api";

Page({
    data: {
        detail:null,
        commentList:[],
        id:0,
        page:0,
        commentId:0,
        isComment:false,
        isReply:false
    },

    onLoad: function (options) {
        let id = options.id
        this.getDynamicDetail(id)
        this.getComment(id)
        this.setData({
            id:id
        })
    },

    comment: function () {
        this.setData({
            isComment:!this.data.isComment,
            isReply:false
        })
    },
    //获取动态详细
    getDynamicDetail: function (id) {
        let params = {}
        let self = this
        dynamicDetail(params,id).then( res => {
            let detail = res.data.obj;
            self.setData({
                detail:detail
            })
        },err =>{
            tip.toast(err.msg)
        })
    },

    commentReply: function(e) {
        let index = e.currentTarget.dataset.index
        let replyId = this.data.commentList[index].id
        this.setData({
            isComment:false,
            commentId:replyId,
            isReply:!this.data.isReply,
        })
    },
    //获取一级评论
    getComment: function (id) {
        let params={}
        let self = this
        let page = self.data.page
        getDynamicComment(params,id,page).then( res => {
            let data = res.data.obj;
            self.setData({
                commentList:data
            })
        },err => {
            tip.toast(err.msg)
        })
    },

    writeReply:function(e) {
        let self = this
        let value = e.detail.value;
        let params = {
            query:{
                "commentId": self.data.commentId,
                "content": value,
                "secondCommentId": 0,
                "secondUserId": 0
            },
            method: "POST"
        }
        replyComment(params).then( res => {
            if(res.data.code == 1){
                tip.toast("评论成功",{},'none');
                self.getComment(this.data.id)
            }
        })
    },
    //写评论
    writeComment: function (e) {
        let self = this
        let value = e.detail.value;
        let params = {
            "content": value,
            "situationId": this.data.id
        }
        dynamicComment(params).then( res => {
            if(res.data.code == 1){
                tip.toast("评论成功",{},'none');
                self.getComment(this.data.id)
            }
        })
    },

    //点赞
    praise:function() {
        let params = {}
        let id = this.data.id
        dynamicLike(params,id).then( res => {
            if(res.data.code == 1){
                tip.toast("点赞成功",function(){},'none')
            }else{
                tip.toast("取消点赞",function(){},'none')
            }
        })
    },
})
