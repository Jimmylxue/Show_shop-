<template>
  <div class="login_container">
    <div class="login-box">
      <!-- logo-->
      <div class="login_logo">
        <img src="../assets/logo.png" />
      </div>
      <div class="login_form">
        <!--输入框  ：model表示绑定信息  ：rules表示绑定一些验证规则  ref是设置引用类型-->
        <el-form
          ref="loginFormRef"
          class="login_info"
          label-width="0px"
          :model="userinfo"
          :rules="login_rules"
        >
          <el-form-item prop="userName">
            <el-input v-model="userinfo.userName" prefix-icon="el-icon-user" placeholder="userName"></el-input>
          </el-form-item>
          <el-form-item prop="passWord">
            <el-input
              v-model="userinfo.passWord"
              prefix-icon="el-icon-warning"
              type="password"
              placeholder="passWord"
            ></el-input>
          </el-form-item>
        </el-form>
        <!--按钮 -->
        <el-row class="btns">
          <a class="register" href="/register">没有账号? 注册一个吧~</a>
          <el-button type="primary" @click="$router.push('/home')">登录</el-button>
          <el-button @click="reset" type="info">重置</el-button>
        </el-row>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      /*
            用户信息
      */
      userinfo: {
        userName: 'jimmy001',
        passWord: 'yshzx171107.'
      },
      login_rules: {
        /*
            添加验证：  1在el-form中绑定一个对象用于验证
                        2在对象的子属下中确定绑定的内容：
                            require：表示不能为空  massage表示错误信息  blur表示当鼠标丢失焦点的时候
                        3在定义完成之后要前往item项中庸 prop绑定我们所定义的项
        */
        userName: [
          { required: true, message: '请输入登录账号 ', trigger: 'blur' },
          {
            min: 6,
            max: 12,
            message: '长度在 6 到 12 个字符',
            trigger: 'blur'
          }
        ],
        passWord: [
          { required: true, message: '请输入登录密码', trigger: 'blur' },
          {
            min: 6,
            max: 15,
            message: '长度在 6 到 15 个字符',
            trigger: 'blur'
          }
        ]
      }
    }
  },
  methods: {
    reset() {
      /* elementui提供了resetFields()方法 能够让表单数据清空 */
      this.$refs.loginFormRef.resetFields()
    },
    login() {
      this.$refs.loginFormRef.validate(valid => {
        if (valid) {
          this.$http.post('/api', this.userinfo).then(data => {
            if (data.data === 1) {
              this.$message({
                message: '更新成功',
                type: 'success'
              })
              /*  sessionStorage的有效期是一次会话，即关闭页面这个信息就会被删除，最适合记录登录信息 */
              window.sessionStorage.setItem('token', 'succee')
              /*  this.$router.push("路由地址")是手动动态的改变路由地址 */
              this.$router.push('/home')
            } else {
              this.$message.error('账号或密码错误哦')
              this.userinfo.passWord = ''
            }
          })
        } else {
          alert('格式错误')
        }
      })
    },
    to() {
      this.$router.push('/register')
    }
  }
}
</script>

<style lang="less" scoped>
.login_container {
  // background-color: #2b4b6b;
  background: url('../assets/img/bg_login.jpeg');
  background-size: contain;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
}
.login-box {
  width: 450px;
  height: 300px;
  background-color: rgba(255, 255, 255, 0.5);
  border-radius: 5px;
}
.login_logo {
  width: 130px;
  height: 130px;
  border: 1px solid #eee;
  border-radius: 50%;
  padding: 10px;
  box-shadow: 0 0 10px #ccc;
  position: absolute;
  left: 50%;
  transform: translate(-50%, -50%);
  background-color: #fff;
  img {
    width: 130px;
    height: 130px;
    border-radius: 50%;
    background-color: #eee;
  }
}
.login_info {
  margin-top: 110px;
  width: 85%;
  margin-left: 30px;
}
.btns {
  display: flex;
  justify-content: flex-end;
  margin-right: 40px;
  position: relative;
}
.register {
  position: absolute;
  left: 0;
  margin-left: 30px;
  line-height: 40px;
}
</style>
