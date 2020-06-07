<template>
  <div class="root">
    <div class="formContainer">
      <div class="imgContainer">
        <img src="../assets/logo.png" alt="" />
      </div>
      <div class="bodiandan">
        <el-form
          :model="ruleForm"
          :rules="rules"
          ref="ruleForm"
          label-width="100px"
          class="demo-ruleForm"
        >
          <el-form-item label="账号" prop="userId">
            <el-input v-model="ruleForm.userId"></el-input>
          </el-form-item>
          <el-form-item label="密码" prop="userPwd">
            <el-input v-model="ruleForm.userPwd"></el-input>
          </el-form-item>
          <el-form-item label="真是姓名" prop="userName">
            <el-input v-model="ruleForm.userName"></el-input>
          </el-form-item>
          <el-form-item label="电子邮箱" prop="userEmail">
            <el-input v-model="ruleForm.userEmail"></el-input>
          </el-form-item>
          <el-form-item label="手机号码" prop="userPhone">
            <el-input v-model="ruleForm.userPhone"></el-input>
          </el-form-item>
          <el-form-item label="注册对象" prop="name">
            <el-input v-model="ruleForm.role"></el-input>
          </el-form-item>
          <div class="bthContainer">
            <a href="/login">去登陆~</a>
            <el-button @click="toRegister" type="primary">立即注册</el-button>
          </div>
        </el-form>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      ruleForm: {
        userId: '173117003',
        userPwd: 'jjc15120',
        userName: '朱正超',
        userEmail: '1512069@qq.com',
        userPhone: '19905076109',
        role: '普通用户',
      },
      rules: {
        userId: [
          { required: true, message: '请输入账号', trigger: 'blur' },
          {
            min: 6,
            max: 12,
            message: '长度在 6 到 12 个字符',
            trigger: 'blur',
          },
        ],
        userPwd: [
          { required: true, message: '请输入密码', trigger: 'blur' },
          {
            min: 6,
            max: 15,
            message: '长度在 6 到 15 个字符',
            trigger: 'blur',
          },
        ],
        userName: [
          { required: true, message: '请输入用户名', trigger: 'blur' },
          {
            min: 6,
            max: 15,
            message: '长度在 6 到 15 个字符',
            trigger: 'blur',
          },
        ],
        userEmail: [
          { required: true, message: '请输入电子邮箱', trigger: 'blur' },
        ],
        userPhone: [
          { required: true, message: '请输入手机号码', trigger: 'blur' },
          { min: 11, max: 11, message: '请输入正确格式', trigger: 'blur' },
        ],
      },
      returnmsg: '',
    }
  },
  methods: {
    toRegister() {
      this.$http.post('/api/register', this.ruleForm).then((response) => {
        this.returnmsg = response.data
        if (this.returnmsg === 1) {
          this.succeed()
          this.$router.push('/login')
        } else {
          this.error()
        }
      })
    },
    succeed() {
      this.$message({
        message: '恭喜你，注册成功！可以区登录啦~',
        type: 'success',
      })
    },
    error() {
      this.$message.error(this.returnmsg)
    },
  },
}
</script>

<style lang="less" scoped>
.root {
  width: 100%;
  height: 100%;
  background: url('../assets/img/register.jpeg');
  background-size: contain;
  display: flex;
  justify-content: center;
  align-items: center;
  .formContainer {
    width: 450px;
    // height: 600px;
    background-color: rgba(255, 255, 255, 0.5);
    position: relative;
    .imgContainer {
      width: 130px;
      height: 130px;
      overflow: hidden;
      background-color: rgb(238, 238, 238);
      border-radius: 50%;
      display: flex;
      justify-content: center;
      align-items: center;
      position: absolute;
      left: 50%;
      transform: translate(-50%, -50%);
      border: 10px solid white;
      img {
        width: 130px;
        height: 130px;
      }
    }
  }
}
.demo-ruleForm {
  color: red;
  padding-left: 15px;
  padding-right: 50px;
  display: flex;
  flex-direction: column;
  align-items: center;
}
.bodiandan {
  margin-top: 100px;
}
button {
  width: 100px;
  height: 40px;
  margin-left: -35px;
  margin-bottom: 15px;
}
.el-form-item {
  width: 380px;
}
.el-form-item__label {
  // margin-right: 10px;
}
.bthContainer {
  width: 100%;
  // background-color: aqua;
  text-align: center;
  a {
    float: left;
    line-height: 40px;
    padding-left: 30px;
  }
}
</style>
