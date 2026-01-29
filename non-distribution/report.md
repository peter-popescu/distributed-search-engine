# M0: Setup & Centralized Computing

> Add your contact information below and in `package.json`.

* name: `Peter Popescu`

* email: `peter_popescu@brown.edu`

* cslogin: `ppopescu`


## Summary

> Summarize your implementation, including the most challenging aspects; remember to update the `report` section of the `package.json` file with the total number of hours it took you to complete M0 (`hours`), the total number of JavaScript lines you added, including tests (`jsloc`), the total number of shell lines you added, including for deployment and testing (`sloc`).


My implementation consists of `13` components addressing T1--8. The most challenging aspect was `implmenting merge` because `I was unfamiliar with JavaScript, so I had some trouble figuring out the best way to manage my data structures to make merging and especially the sorting at the end simple and efficient`.

```
I also experimented with trying to make some efficiency changes, namely trying to combine getText and getUrls to avoid reading the same file twice, but did not see much of a performance difference.
```


## Correctness & Performance Characterization


> Describe how you characterized the correctness and performance of your implementation.


To characterize correctness, we developed `18 tests` that test the following cases:
```
- empty/null cases
- cases with only stop words (query) or stop tokens (end-to-end)
- empty and highly specific queries
- queries with terms only in url
```


*Performance*: The throughput of various subsystems is described in the `"throughput"` portion of package.json. The characteristics of my development machines are summarized in the `"dev"` portion of package.json.

```
To measure performance, I created an alternate engine that outputs timestamps when starting and finishing indexing and crawling. I was able to then analyze the time taken and number of files processed afterwards to calculate throughput. For queries I just used the large globalIndex resulting from the long-term performance test and queried the same common term 100 times.
```

## Wild Guess

> How many lines of code do you think it will take to build the fully distributed, scalable version of your search engine? Add that number to the `"dloc"` portion of package.json, and justify your answer below.

```
I feel like it will probably take on the order of 10x to build the fully distributed version of this code. Implmenting everything from message passage to recovery will require a lot of code by itself, not to mention the number of tests and metric measurement.
```
