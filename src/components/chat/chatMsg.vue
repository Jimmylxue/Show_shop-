<template>
  <div class="chatMsg">
    <div class="title">
      <!-- {{user}} -->
      <span>{{user.uname}}</span>
    </div>
    <div class="content">
      <div class="chatmsg">
        <div
          class="conts"
          v-for="(item, index) in msg"
          :key="index"
          :class="item.client? 'change' : ''"
        >
          <div class="item">
            <div class="headers">
              <img
                :src="item.client?require('@/assets/header.png'):user.header"
                width="100%"
                height="100%"
                alt
              />
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
      userList: [],
      userid: ''
    }
  },
  props: ['user'],
  watch: {
    obj(before, now) {
      console.log(before, now)
    }
  },
  mounted() {
    // this.$sockets.on('connection')
    this.sockets.listener.subscribe('ids', data => {
      this.id = data
      this.$socket.emit('backstage', this.id)
    })
    this.sockets.listener.subscribe('toback', data => {
      if (data.error) {
        this.$swal('哟吼~', '对方未在线~', 'warning')
        this.msg.pop()
      } else {
        this.msg.push(data)
        console.log(this.msg)
        console.log(data)
      }
    })
    console.log('aaaa', this.user)
    // this.userid = this.user.userid
    // console.log('aaa', this.obj)
  },
  methods: {
    send() {
      if (this.sendText == '') {
        this.$message.error('不能发送空的消息哦~')
      } else {
        let id = this.$socket.id
        let obj = {
          userid: this.user.userid,
          client: 'back',
          text: this.sendText
        }
        console.log('userid', obj)
        this.$socket.emit('tousers', obj)
        this.msg.push(obj)
        console.log(obj.aaa)
        this.sendText = ''
      }
    }
  }
}
</script>

<style lang="less" scoped>
.chatMsg {
  // width: 72%;
  height: 100%;
  display: flex;
  // padding-bottom: 10px;
  flex-direction: column;
  .title {
    width: 100%;
    height: 70px;
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
    // flex-grow: 1;
    > ::-webkit-scrollbar {
      width: 0px;
    }
    height: 390px;
    // height: 100%;
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
</style>