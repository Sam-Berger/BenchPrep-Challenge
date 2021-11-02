<template>
  <div id="app">
    <img alt="Vue logo" src="./assets/logo.png">
    <Quotes msg = "Quote imbed message">
    </Quotes>
    <Practice msg="fdsdfsdfsd"/>
    <HelloWorld msg="Welcome to Your Vue.js AppIII"/>
  </div>
</template>

<script>
import HelloWorld from './components/HelloWorld.vue'
import Practice from './components/Practice.vue'
import Quotes from './components/Quotes.vue'
// import quoteData from 'https://gist.githubusercontent.com/benchprep/dffc3bffa9704626aa8832a3b4de5b27/raw/quotes.json'

export default {
  name: 'App',
  components: {
    HelloWorld,
    Practice,
    Quotes
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
