<template>
  <div id="app">
    <Quotes></Quotes>
  </div>
</template>

<script>
import Quotes from './components/Quotes.vue'

export default {
  name: 'App',
  components: {
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
