import tip from './tip'

// let apiUrl = "https://www.yayanshequ.com"
let apiUrl = "https://api.yayanshequ.com"

const wxRequest = (params = {}, url, isLoading = true) => {
    if(isLoading){
        tip.loading();
    }
    let data = params.query || {};
    //"7de5512d-63a2-4ed1-895f-df842068fe5b" //
    let token = qq.getStorageSync("token")
    if(!token){
        qq.switchTab({
            url:'pages/home/home'
        })
        return
    }
    return new Promise( ((resolve, reject) => {
        qq.request({
            url: apiUrl + url,
            method: params.method || 'GET',
            data: data,
            header: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer '+ token
            },
            success(res) {
                if (isLoading){
                    tip.loaded();
                }
                resolve(res)
            },
            fail(res) {
                reject(res)
                console.log(res)
            }
        })
    }))

};



module.exports = {
    wxRequest
}
