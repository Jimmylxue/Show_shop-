<template>
  <el-container class="home_container">
    <el-header>
      <div>
        <img class="header" src="../assets/logo.png" alt />
        <span>Show_Shop后台管理系统</span>
      </div>
      <img
        class="portrait"
        @click="$router.push('/admin')"
        src="../assets/img/portrait.jpg"
        alt
      />
      <el-button type="info" @click="logout">退出</el-button>
    </el-header>

    <el-container>
      <el-aside :width="asideTroggle ? '65px' : '200px'">
        <!-- element-ui为我们提供了导航菜单，所以我们可以不用自己写 -->
        <div class="button_troggler" @click="troggle">
          <i
            :class="
              asideTroggle ? 'el-icon-d-arrow-right' : 'el-icon-d-arrow-left'
            "
          ></i>
        </div>
        <el-menu
          background-color="#333744"
          text-color="#fff"
          active-text-color="#409eff"
          unique-opened
          :collapse="asideTroggle"
          :collapse-transition="false"
          :router="true"
          :default-active="$route.path"
        >
          <!-- router是elementui提供的作为激活vue-router的模式 -->
          <!-- 1级导航区 -->
          <el-submenu
            :index="item.data.id + ''"
            v-for="item in menuList"
            :key="item.data.id"
          >
            <template slot="title">
              <i class="el-icon-s-custom"></i>
              <span>{{ item.data.authName }}</span>
            </template>
            <!-- 二级导航区 -->
            <!-- :index就是将来点击时路由地址的值 -->
            <el-menu-item
              :index="secitem.path"
              v-for="secitem in item.data.children"
              :key="secitem.id"
            >
              <i class="el-icon-menu"></i>
              <span>{{ secitem.authName }}</span>
            </el-menu-item>
          </el-submenu>
        </el-menu>
      </el-aside>
      <el-main>
        <router-view></router-view>
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
export default {
  data() {
    return {
      menuList: [
        {
          data: {
            id: 101,
            authName: '用户管理',
            children: [
              {
                id: 1001,
                authName: '用户列表',
                path: '/user',
              },
            ],
          },
        },
        {
          data: {
            id: 201,
            authName: '权限管理',
            children: [
              {
                id: 2001,
                authName: '角色列表',
                path: '/roles',
              },
              {
                id: 2002,
                authName: '权限列表',
                path: '/right',
              },
            ],
          },
        },
        {
          data: {
            id: 301,
            authName: '商品管理',
            children: [
              {
                id: 3001,
                authName: '商品列表',
                path: '/goods',
              },
              {
                id: 3002,
                authName: '库存管理',
                path: '/stock',
              },
              {
                id: 3003,
                authName: '商品操作',
                path: '/addGood',
              },
              {
                id: 3004,
                authName: '商品类别管理',
                path: '/classify',
              },
            ],
          },
        },
        {
          data: {
            id: 401,
            authName: '订单管理',
            children: [
              {
                id: 4001,
                authName: '订单列表',
                path: '/list',
              },
            ],
          },
        },
        {
          data: {
            id: 501,
            authName: '数据统计',
            children: [
              {
                id: 5001,
                authName: '数据列表',
                path: 'data',
              },
            ],
          },
        },
        {
          data: {
            id: 601,
            authName: '广告管理',
            children: [
              {
                id: 5001,
                authName: '广告列表',
                path: 'data',
              },
            ],
          },
        },
        {
          data: {
            id: 701,
            authName: '评论管理',
            children: [
              {
                id: 7001,
                authName: '商品评论',
                path: 'data',
              },
            ],
          },
        },
        {
          data: {
            id: 801,
            authName: '客服沟通',
            children: [
              {
                id: 8001,
                authName: '进入聊天',
                path: '/chat',
              },
            ],
          },
        },
        {
          data: {
            id: 901,
            authName: '界面设置',
            children: [
              {
                id: 9001,
                authName: '系统界面',
                path: '/print',
              },
            ],
          },
        },
        {
          data: {
            id: 1001,
            authName: '视频管理',
            children: [
              {
                id: 10001,
                authName: '首页视频',
                path: '/video',
              },
            ],
          },
        },
      ],
      asideTroggle: false,
    }
  },
  methods: {
    logout() {
      /*  清空登录缓存 */
      this.$swal({
        title: '确定要退出登录吗?',
        text: '一旦退出登录，你将暂时看不到新的消息!',
        icon: 'warning',
        // buttons: true,
        buttons: ['Oh noez!', 'Aww yiss!'],
        showCancelButton: true,
        dangerMode: true,
      }).then(willDelete => {
        if (willDelete) {
          this.$swal('哟吼~', '退出成功~', 'success')
          window.sessionStorage.clear()
          /*  路由跳转 */
          this.$router.push('/login')
        } else {
          this.$swal('哎哟~', '退出失败~', 'warning')
        }
      })
    },
    troggle() {
      this.asideTroggle = !this.asideTroggle
    },
  },
}
</script>

<style lang="less" scoped>
.home_container {
  height: 100vh;
}
.el-header {
  background-color: #373d41;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-left: 0;
  position: relative;
  .portrait {
    height: 90%;
    border-radius: 50%;
    position: absolute;
    right: 120px;
    // transform: translateX(720px);
    cursor: pointer;
    transition: all 0.3s ease-in-out;
    transition: 1s all ease;
    &:hover {
      box-shadow: 0 0 10px #2ecc71;
      transform: rotate(360deg);
    }
  }
  > div {
    display: flex;
    align-items: center;
    > .header {
      height: 60px;
      position: relative;
    }
    .show {
      width: 60px;
      height: 60px;
      background-color: #2ecc71;
      position: absolute;
      bottom: 0;
    }
    > span {
      color: white;
      font-size: 20px;
      margin-left: 15px;
    }
  }
}
.el-aside {
  background-color: #333744;
  transition: 0.5s all ease;
  .el-menu {
    border-right: 0;
  }
}
.el-main {
  background-color: #eaedf1;
  padding: 0;
}
.button_troggler {
  color: white;
  height: 24px;
  line-height: 24px;
  text-align: center;
  background-color: #4a5064;
  cursor: pointer;
  letter-spacing: 0.2em;
}
</style>
