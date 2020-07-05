<template>
  <div class="chat">
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/main' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>客服</el-breadcrumb-item>
    </el-breadcrumb>
    <div class="chatfrom">
      <div class="list">
        <div class="search">
          <div>
            <input type="text" placeholder="搜索" />
            <i class="el-icon-search"></i>
          </div>
          <i class="el-icon-plus"></i>
        </div>
        <div v-for="(item, index) in userList" :key="index" class="items">
          <div class="item">
            <div>
              <img :src="item.header" width="100%" height="100%" alt />
            </div>
            <div>
              <p>
                <span>{{ item.uname }}</span>
                <small>19:04</small>
              </p>
              <p>还有货吗老板?</p>
            </div>
          </div>
        </div>
      </div>
      <div class="form">
        <div class="title">
          <span>要口饭吃</span>
        </div>
        <div class="content">
          <div class="chatmsg">
            <div
              class="conts"
              v-for="(item, index) in msg"
              :key="index"
              :class="item.userid === undefined ? '' : 'change'"
            >
              <div class="item">
                <div class="headers">
                  <img src="@/assets/img/portrait.jpg" width="100%" height="100%" alt />
                </div>
                <div class="form">{{ item.text }}</div>
              </div>
            </div>
          </div>
        </div>
        <div class="text">
          <p class="bar">
            <i class="el-icon-eleme"></i>
            <i class="el-icon-folder-opened"></i>
          </p>
          <textarea v-model="sendText" style="resize:none;" name id cols="30" rows="10"></textarea>
          <p class="send">
            <button @click="send">发送</button>
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      sendText: 'hello',
      id: '',
      msg: [
        {
          text:
            'Hi，福州豪豪，你好，小蜜在此等主人很久了。享受便捷服务，您可手机淘宝扫一扫右侧二维码，直达手机版小蜜体验更佳哦！Hi，福州豪豪，你好，小蜜在此等主人很久了。享受便捷服务，您可手机淘宝扫一扫右侧二维码，直达手机版小蜜体验更佳哦！Hi，福州豪豪，你好，小蜜在此等主人很久了。享受便捷服务，您可手机淘宝扫一扫右侧二维码，直达手机版小蜜体验更佳哦！',
          flag: 0
        },
        { text: 'Hello World', flag: 1 }
      ],
      userList: []
    }
  },
  mounted() {
    // this.$sockets.on('connection')
    this.sockets.listener.subscribe('ids', data => {
      this.id = data
      this.$socket.emit('backstage', this.id)
    })
    this.sockets.listener.subscribe('toback', data => {
      this.msg.push(data)
    })
    this.getUserList()
  },
  methods: {
    async getUserList() {
      let res = await this.$api.user.getUser()
      this.userList = res.data
    },
    send() {
      let id = this.$socket.id
      let obj = { userid: '173117031', text: this.sendText }
      this.$socket.emit('tousers', obj)
      this.msg.push(obj)
      console.log(obj.aaa)
      this.sendText = ''
    }
  }
}
</script>

<style lang="less" scoped>
.chat {
  padding: 20px;
}
.chatfrom {
  width: 1000px;
  height: 570px;
  background-color: rgb(245, 245, 245);
  margin: 100px auto 0 auto;
  display: flex;
  .list {
    width: 28%;
    height: 100%;
    background-color: rgb(222, 222, 222);
    display: flex;
    flex-direction: column;
    .search {
      width: 100%;
      height: 60px;
      background-color: rgb(237, 234, 232);
      display: flex;
      align-items: center;
      // margin: 15px 0 0 15px;
      div {
        position: relative;
        width: 190px;
        margin: 15px 0 0 15px;
        input {
          width: 150px;
          height: 25px;
          padding-left: 25px;
          border: none;
          background-color: rgb(220, 217, 216);
        }
        input::placeholder {
          font-size: 12px;
          color: rgb(88, 88, 88);
        }
        i {
          position: absolute;
          left: 0;
          margin-top: 5px;
          margin-left: 5px;
        }
      }
      & > i {
        width: 25px;
        height: 25px;
        background-color: rgb(220, 217, 216);
        color: rgb(88, 88, 88);
        text-align: center;
        line-height: 25px;
        margin-top: 15px;
      }
    }
    .items {
      flex-flow: 1;
      // padding: 0 15px;
      .item {
        width: 100%;
        height: 60px;
        background-color: rgb(223, 222, 223);
        display: flex;
        align-items: center;
        &:hover {
          background-color: rgb(197, 197, 197);
        }
        & > div:nth-child(1) {
          width: 40px;
          height: 40px;
          margin-left: 15px;
        }
        & > div:nth-child(2) {
          flex-grow: 1;
          display: flex;
          flex-direction: column;
          padding-left: 10px;
          margin-right: 15px;
          & > p:nth-child(1) {
            display: flex;
            justify-content: space-between;
            align-items: center;
            span {
              color: #000;
              font-size: 15px;
            }
            small {
              color: rgb(153, 153, 153);
            }
          }
          & > p:nth-child(2) {
            color: rgb(153, 153, 153);
            font-size: 13px;
          }
        }
      }
    }
  }
  .form {
    // width: 72%;
    height: 100%;
    display: flex;
    flex-direction: column;
    .title {
      width: 100%;
      height: 83px;
      background-color: rgb(245, 245, 245);
      border-bottom: 1px solid rgb(231, 231, 231);
      box-shadow: 0 0 5px rgb(231, 231, 231);
      display: flex;
      align-items: center;
      span {
        color: #000;
        font-size: 18px;
        padding: 0 25px;
      }
    }
    & > div:nth-child(2) {
      flex-grow: 1;
      height: 100%;
      padding: 0 25px;
      .chatmsg {
        width: 100%;
        height: 100%;
        overflow: auto;
        .conts {
          width: 100%;

          .item {
            max-width: 500px;
            // height: 40px;
            // background-color: slateblue;
            margin-top: 12px;
            display: flex;
            cursor: pointer;
            .headers {
              width: 40px;
              height: 40px;
              // background-color: slategray;
              border-radius: 10px;
            }
            .form {
              min-height: 30px;
              max-width: 450px;
              background-color: #fff;
              color: #333;
              margin-left: 8px;
              padding: 5px 10px;
              border-radius: 8px 0 8px 0;
              font-size: 14px;
            }
          }
        }
        .change {
          display: flex;
          flex-direction: row-reverse;
          .item {
            flex-direction: row-reverse;
            .form {
              margin-right: 8px;
              border-radius: 0 8px 0 8px;
              background-color: rgb(152, 225, 101);
              color: #333;
              padding-bottom: 0px;
              min-height: 30px;
            }
          }
        }
      }
    }
    & > div:nth-child(3) {
      // width: 100%;
      height: 140px;
      background-color: #fff;
      padding: 5px 25px;
      .bar {
        // padding-left: ;
        i {
          transform: scale(1.1);
          margin-right: 5px;
        }
      }
      textarea {
        margin-left: 30px;
        width: 680px;
        height: 45px;
        margin: 0 auto;
        border: none;
        outline: none;
        padding-top: 5px;
      }
      .send {
        display: flex;
        justify-content: flex-end;
        button {
          width: 70px;
          height: 30px;
          border-radius: 5px;
          border: none;
          outline: none;
          color: rgb(96, 96, 96);
          &:hover {
            background-color: rgb(18, 150, 17);
            color: #fff;
          }
        }
      }
    }
  }
}
</style>
