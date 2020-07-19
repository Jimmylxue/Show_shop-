<template>
  <div class="searchBtn">
    <div class="nav">
      <el-card class="search">
        <div class="container">
          <div class="logo">
            <img width="100%" height="100%" src="@/assets/img/logo.jpg" alt />
          </div>
          <div class="searchbar">
            <div class="inputs">
              <input type="text" placeholder="请输入商品信息 如:小米10" />
              <div class="click fa fa-search fa-lg"></div>
            </div>
            <div class="links">
              <ul>
                <li v-for="(item,index) in btnsList" :key="index">
                  <span>
                    {{item.name}}
                    <i @click="delOne(item.btnid)" class="el-icon-close"></i>
                  </span>
                </li>
              </ul>
            </div>
          </div>
          <div class="guanggao">
            <img src="@/assets/img/guanggao.jpg" alt />
          </div>
        </div>
      </el-card>
    </div>
    <div class="add_container">
      <el-card class="card">
        <el-form ref="adds" :model="addMsg" :rules="rules" class="forms">
          <el-form-item label="名称" prop="name">
            <el-input v-model="addMsg.name" placeholder="请输入标签名称"></el-input>
          </el-form-item>
          <el-form-item label="商品">
            <el-input v-model="addMsg.url" placeholder="请输入商品链接"></el-input>
          </el-form-item>
        </el-form>
        <div class="btns">
          <el-button class="btn" @click="addBtns" type="success">确定</el-button>
        </div>
      </el-card>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      btnsList: [],
      addMsg: {
        name: '',
        url: ''
      },
      rules: {
        name: [
          { required: true, message: '请输入快捷链接名称', trigger: 'blur' },
          { min: 2, max: 15, message: '长度在 2 到 15 个字符', trigger: 'blur' }
        ]
      }
    }
  },
  mounted() {
    this.getBtns()
  },
  methods: {
    async getBtns() {
      let res = await this.$api.navBtbs.getBnts()
      this.btnsList = res.data
    },
    async delOne(id) {
      let params = {}
      params.id = id
      let res = await this.$api.navBtbs.dekBtn(params)
      if (res.data.code == 200) {
        this.$swal('哟吼~', res.data.message, 'success')
        this.getBtns()
        return
      }
      this.$swal('哦吼~', res.data.message, 'error')
    },
    addBtns() {
      this.$refs['adds'].validate(async valid => {
        if (!valid) {
          return false
        }
        let params = this.addMsg
        console.log(params)
        let res = await this.$api.navBtbs.addBtns(params)
        if (res.data.code == 200) {
          this.$swal('哟吼~', res.data.message, 'success')
          this.getBtns()
          return
        }
        this.$swal('哦吼~', res.data.message, 'error')
      })
    }
  }
}
</script>

<style lang="less" scoped>
.search {
  .container {
    margin: 0 auto;
    // border: 1px solid #ccc;
    width: 1480px;
    // height: 300px;
    display: flex;
    .logo {
      width: 260px;
      height: 120px;
      // background-color: #2ecc71;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    .searchbar {
      flex-grow: 1;
      height: 120px;
      // background-color: #e67e22;
      display: flex;
      flex-direction: column;
      justify-content: center;
      position: relative;
      .inputs {
        width: 90%;
        height: 50px;
        border: 3px solid #e74c3c;
        position: relative;
        margin-top: 15px;
        input {
          width: 100%;
          height: 100%;
          border: none;
          outline: none;
          padding-left: 1rem;
          font-size: 1.1rem;
        }
        .click {
          width: 48px;
          height: 50px;
          background-color: #e74c3c;
          position: absolute;
          right: -3px;
          top: 0px;
          display: flex;
          justify-content: center;
          align-items: center;
          padding-left: 4px;
          color: white;
        }
      }
      .links {
        width: 90%;
        // margin-bottom: -10px;
        ul {
          // background-color: salmon;
          display: flex;
          padding: 18px 0 0px 0;
          justify-content: space-around;
          li {
            color: #666;
            span {
              padding: 10px 20px;
              display: inline-block;
              // background-color: skyblue;
              border: 1px dashed #ccc;
              position: relative;
              i {
                position: absolute;
                right: 2px;
                top: 2px;
              }
            }
          }
        }
      }
    }
    .guanggao {
      width: 240px;
      height: 120px;
      // background-color: #9b59b6;
      display: flex;
      justify-content: center;
      align-items: center;
    }
  }
}

.add_container {
  width: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  .card {
    width: 100%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    .forms {
      width: 500px;
    }
    .btns {
      width: 100%;
      display: flex;
      justify-content: center;
      .btn {
        width: 100px;
      }
    }
  }
}
</style>