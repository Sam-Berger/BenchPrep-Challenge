
<template>
  <div class="quotes">
    <!-- <h1>{{ msg }}</h1> -->
    <!-- <h2>{{objectExample}}</h2>

    <h2>{{objectExample.qwe}}</h2> -->
    <h2>Quotes!!!</h2>
    <ul>
        <div v-for="item in quotesData" v-bind:key="item">
            <h1>{{item.quote}}</h1>
            <h2>{{item.source}}</h2>
            <h3>{{item.context}}</h3>
            <h4>{{item.theme}}</h4>
        </div>
    </ul>

    <h2>{{quotesData[0]}}</h2>
    <p>QUOTES END</p>
  </div>
</template>

<script>
export default {
  name: 'Quotes',
  props: {
    msg: String,
  },
  data: function () {
    return {
      foo: 'bar',
      objectExample: {
          qwe: "wer",
          tre: "www"
      },
      quotesData: []
    }
  },

  created() {
  // Simple GET request using fetch
  fetch('https://gist.githubusercontent.com/benchprep/dffc3bffa9704626aa8832a3b4de5b27/raw/quotes.json')
    .then(response => response.json())
    .then(data => this.quotesData = data);
  }
}

//   created() {
//   // Simple GET request using fetch
//   fetch('https://gist.githubusercontent.com/benchprep/dffc3bffa9704626aa8832a3b4de5b27/raw/quotes.json')
//     .then(response => {
//             console.log(response);

//             // this.quotesData = response;
//     }
//   }
// }

//   created: {
//     axios.get('http://http://ideazfactory.in/library/jj.json')
//       .then(response => {
//          this.cars = response;
//       }
//   }

//   methods: {
      
//     // increment() {
//     //   // `this` will refer to the component instance
//     //   this.count++
//     // }

//     created() {
//         axios.get('https://gist.githubusercontent.com/benchprep/dffc3bffa9704626aa8832a3b4de5b27/raw/quotes.json')
//         .then(response => {
            // this.quotesData = response;
//         }
//     }
//   }

</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
