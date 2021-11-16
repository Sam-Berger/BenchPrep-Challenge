<template>
    <div class="quotes">
        <div>
            <h1>Here Are Some Quotes!</h1>
            <button v-on:click="showAllQuotes()">Show All Quotes</button>
            <button v-on:click="showMovieQuotes()">Show Only Movie Quotes</button>
            <button v-on:click="showGameQuotes()">Show Only Game Quotes</button>
            <br>
            <input v-model="message" placeholder="Put Search Text Here">
            <button v-on:click="search()">Search</button>
                <table class="table table-striped">
                    <tbody>
                        <tr v-for="item in paginatedQuotes" v-bind:key="item">
                            <td>
                                <h2>{{item.quote}}</h2>
                                <h5>-{{item.source}} in {{item.context}}</h5>
                                <div>category: {{item.theme}}</div>
                            </td>
                        </tr>
                    </tbody>
                </table>
        </div>
        <div class="pagination-nav">
            <button v-on:click="pageDown()" v-if="page>1">Prev</button>
            <button v-on:click="pageUp()" v-if="page <pages">Next</button>
        </div>
    </div>
</template>

<script>
export default {
    name: 'Quotes',
    data: function () {
        return {
            quotesData: [],
            fullQuotesData: [],
            page: 1,
            perPage: 15,
            message: "",
            searchedMessage: "",
            isGameQuotes: false,
            isMovieQuotes: false,
            isSearched: false
        }
    },
    methods:{
        getData() {
            fetch('https://gist.githubusercontent.com/benchprep/dffc3bffa9704626aa8832a3b4de5b27/raw/quotes.json')
            .then(response => response.json())
            .then(data => {this.quotesData = data;
            //if we just take quotesData and copy it, this new array is bound to it. 
            // We need an unbound one to manipulate, so use a for loop
            let postData = [];
            for(let i=0; i<this.quotesData.length; i++) {
                postData.push(Object.assign({}, this.quotesData[i]));
            }
            this.fullQuotesData = postData 
            })
        },

        paginate(quotesData) {
            let from = (this.page - 1) * this.perPage
            let to = this.page * this.perPage
            return quotesData.slice(from,to)
        },

        pageUp() {
            this.page++
        },

        pageDown(){
            this.page--
        },

        showGameQuotes(){
            return this.isGameQuotes = true, this.isMovieQuotes = false, this.page = 1
        },

        showMovieQuotes(){
            return this.isGameQuotes = false, this.isMovieQuotes = true, this.page = 1
        },

        showAllQuotes(){
            return this.isGameQuotes = false, this.isMovieQuotes = false, this.page = 1
        },

        search(){
            if (this.message != "") {
                this.searchedMessage = this.message
                return this.isSearched = true
            }
        }
    },
    computed: {
        filteredQuotes: function () {
            let filteredQuotesArray = this.fullQuotesData
            if (this.isGameQuotes) {
                filteredQuotesArray = this.fullQuotesData.filter(quote => quote.theme == "games")
            }
            if (this.isMovieQuotes) {
                filteredQuotesArray = this.fullQuotesData.filter(quote => quote.theme == "movies")
            }
            if (this.isSearched) {
                filteredQuotesArray = filteredQuotesArray.filter(item => ((item.quote.toLowerCase())).includes(this.searchedMessage.toLowerCase()))
            }            
            return filteredQuotesArray
        },
        paginatedQuotes: function() {
            return this.paginate(this.filteredQuotes)
        },
        pages: function() {
            return Math.ceil(this.filteredQuotes.length/this.perPage)
        }
    },
    //I DO NOT NEED THIS WATCH PROPERTY. AT ONE POINT I DID BUT THIS FUNCTIONS PERFECTLY WITHOUT IT.
    // watch: {
    //     filteredQuotes: {
    //         deep: true,
    //         handler: function (newVal) {
    //             this.filteredQuotesArray = newVal
    //         }
    //     },
    // },
    created() {
        this.getData()
    },
}
</script>