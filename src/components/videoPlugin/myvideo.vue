<template>
  <!-- <div class="myVideo"> -->
  <div class="test_two_box">
    <video id="myVideo" class="video-js">
      <source :src="videoUrl" type="video/mp4" />
      <!-- <source src="//vjs.zencdn.net/v/oceans.mp4" type="video/mp4" /> -->
    </video>
    <i class="fa fa-window-close-o" @click="close" aria-hidden="true"></i>
  </div>
  <!-- </div> -->
</template>

<script>
export default {
  data() {
    return {
      videoUrl: ''
    }
  },
  props: ['url'],
  watch: {
    url(to, from) {
      console.log('hello')

      this.videoUrl = ''
      this.videoUrl = to
      console.log('nowurl', this.videoUrl)
      setTimeout(() => {
        this.initVideo()
      }, 1000)
    }
  },
  mounted() {
    this.videoUrl = this.url
    setTimeout(() => {
      this.initVideo()
    }, 1000)
  },
  methods: {
    initVideo() {
      this.$video(myVideo, {
        //确定播放器是否具有用户可以与之交互的控件。没有控件，启动视频播放的唯一方法是使用autoplay属性或通过Player API。
        controls: true,
        //自动播放属性,muted:静音播放
        autoplay: 'muted',
        //建议浏览器是否应在<video>加载元素后立即开始下载视频数据。
        preload: 'auto',
        //设置视频播放器的显示宽度（以像素为单位）
        width: '1200px',
        //设置视频播放器的显示高度（以像素为单位）
        height: '600px'
      })
    },
    close() {
      // alert('close')
      // this.$vnode.pause()
      this.videoUrl = ''
      this.$emit('closeVideo', true)
    }
  }
}
</script>

<style lang="less" scoped>
.myVideo {
  width: 100vw;
  height: 100vh;
  background-color: rgba(0, 0, 0, 0.8);
  display: flex;
  justify-content: center;
  align-items: center;
}
.test_two_box {
  width: 1200px;
  height: 600px;
  position: relative;
  i {
    position: absolute;
    top: 15px;
    right: 15px;
    transform: scale(1.8);
    color: #fff;
  }
}
</style>
