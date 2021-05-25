# eulaw

An `R` package to access data from the `eulaw.app` API. This package provides an intuitive, easy-to-use R interface for the `eulaw.app` API. This API provides access to a variety of research-ready databases, including:

+ The Evolution of European Union Law ([EvoEU](https://jfjelstul.github.io/evoeu/)) Database
+ The European Commission Internal Organization ([ECIO](https://jfjelstul.github.io/ecio/)) Database
+ The European Union Infringement Procedure ([EUIP](https://jfjelstul.github.io/euip/)) Database
+ The European Union State Aid ([EUSA](https://jfjelstul.github.io/eusa/)) Database
+ The European Union Technical Regulations ([EUTR](https://jfjelstul.github.io/eutr/)) Database
+ The European Union Member States ([EUMS](https://jfjelstul.github.io/eums/)) Database. 

Replication materials and documentation are available in the GitHub respository for each database. 

The `eulaw.app` API, the `eulaw` package, and all of the databases were created by Joshua C. Fjelstul, Ph.D.

## Installation

You can install the latest development version of the `eulaw` package from GitHub:

```r
# install.packages("devtools")
devtools::install_github("jfjelstul/eulaw")
```

## Documentation

The `eulaw` package includes comprehensive documentation. You can also read the documentation on the [package website](https://jfjelstul.github.io/eulaw/). You can use the function `search_codebook()` to read the documentation for each database.

## Citation

If you use data from the `eulaw` package in a project or paper, please cite the package:

> Joshua Fjelstul (2021). eulaw: An R Interface to the eulaw.app API. R package version 0.1.0.9000.

The `BibTeX` entry for the package is:

```
@Manual{,
  title = {eulaw: An R Interface to the eulaw.app API},
  author = {Joshua Fjelstul},
  year = {2021},
  note = {R package version 0.1.0.9000},
}
```

## Problems

If you notice an error in the data or a bug in the `R` package, please report it [here](https://github.com/jfjelstul/eulaw/issues).

## Example: getting data on the EU infringement procedure

Suppose we want directed dyad-year data on letters of formal notice and reasoned opinions under Article 258 of the Treaty on the Functioning of the European Union (TFEU) in infringement cases. We can get data on the infringement procedure from the European Union Infringement Procedure (EUIP) Databse, which is part of the European Union Compliance Project (EUCP). We can easily get exactly the data we're looking for right from `R` in just a few easy steps using the `eulaw` package, which is an `R` interface for the `eulaw.app` API. This API provides access to a variety of research-ready databases about EU law, including the EUIP Database. 

### Looking up databases

First, let's double-check what datasets we have to work with. To see the databases that are available via the `eulaw.app` API, we can use the `list_databases()` function.

```r
> list_databases()
Requesting data via the eulaw.app API...
Response received...
# A tibble: 6 x 2
  database_id database
        <int> <chr>   
1           1 evoeu   
2           2 ecio    
3           3 euip    
4           4 eusa    
5           5 eutr    
6           6 eums  
```

This function requests information via the `evoeu.app` API and returns a `tibble` (see the `tidyverse`) that lists the available databases. Here, we want the `euip` database.

### Looking up datasets

Next, we need to pick the dataset in the `euip` database that has directed dyad-year data on decisions in infringement cases. To see the datasets that are available in the `euip` database, we can use the `list_datasets` function. The function takes one argument, which is the name of a database, as given by `list_databases()`. 

```r
> list_datasets(database = "euip")
Requesting data via the eulaw.app API...
Response received...
# A tibble: 22 x 2
   dataset_id dataset         
        <int> <chr>           
 1          1 cases           
 2          2 cases_ts        
 3          3 cases_ts_ct     
 4          4 cases_csts_ms   
 5          5 cases_csts_ms_ct
 6          6 cases_csts_dp   
 7          7 cases_csts_dp_ct
 8          8 cases_ddy       
 9          9 cases_ddy_ct    
10         10 cases_net       
# … with 12 more rows
```

To see the whole list, we need to assign the output to an object, as in `datasets <- list_datasets(database = "euip")` and view it using `View(datasets)`. We're looking for `decisions_ddy`, which contains directed dyad-year data on decisions.

### Checking the codebook

If we don't already know we're looking for the `decisions_ddy` dataset, we can look at the codebook for the `euip` database, which contains descriptions of each dataset and variable, to see what's available find the right dataset. We can look at the codebook for the `euip` database using the function `search_codebook()`. This function has one required argument, `database`, and one optional argument, `dataset`. It returns a `tibble`. Here, we would run:

```r
> codebook <- search_codebook(database = "euip")
Requesting data via the eulaw.app API...
Response received...
View(codebook)
```

If we already know we're looking for the `decisions_ddy` dataset, but we still want to double-check the dataset description (or the variable descriptions), we would run:

```r
> codebook <- search_codebook(database = "euip", dataset = "decisions_ddy")
Requesting data via the eulaw.app API...
Response received...
View(codebook)
```

This would give us just the section of the codebook for the `decisions_ddy` dataset.

### Searching for data

Now that we know what database (`ecio`) and dataset ('decisions_ddy') we need and how to read the documentation for the data, we're ready to search the dataset and download data. Here, we're specifically looking for directed dyad-year data on letters of formal notice and reasoned opinions (under Article 258 TFEU), so we don't need the entire `decisions_ddy` dataset, which also includes data on referrals to the Court and decisions under Article 260 TFEU. Instead of downloading the entire dataset, we can filter the data using the API and download just what we're looking for. 

We can use the `search_data()` function to filter and download the data. This function takes two required arguments, `database` and `dataset`, and one optional argument, `parameters`. The `parameters` argument should be a named `list` that specifies the API parameters we want to use. API parameters let you filter the data. 

### Looking up API parameters

We can see the API parameters for the `decisions_ddy` dataset using the function `list_parameters()`. This function has two required arguments, `database` and `dataset`. Here, we would run:

```r
> list_parameters(database = "euip", dataset = "decisions_ddy")
Requesting data via the eulaw.app API...
Response received...
# A tibble: 5 x 2
  parameter_id parameter        
         <int> <chr>            
1            1 year_min         
2            2 year_max         
3            3 department_id    
4            4 member_state_id  
5            5 decision_stage_id
```

We can see there are 5 API parameters for the `decisions_ddy` dataset. Each parameter corresponds to exactly one variable in the dataset. There is an API parameter for all variables ending in `_id`. The exception to this rule is if the dataset includes a `year` variable. In the case of a `year` variable, there are two API parameters, `year_min` and `year_max`. These API parameters allow you to specify a range. 

### Looking up API parameter values

We want to use the `decision_stage_id` parameter and the `year_min` parameter, which will let us filter the data by decision stage and year. For the `year_min` parameter, we just need to specify a year. For the parameter `decision_stage_id`, we need to know what values to provide in order to get letters of formal notice and reasoned opinions under Article 258 TFEU. We can always look up the corresponding variables, `decision_stage_id` and `decision_stage`, in the codebook (as above) to learn more. But we can easily see the unique values of `decision_stage_id` using the function `list_parameter_values()`. This function has two required arguments, `database` and `parameter`. API parameters are often used across multiple datasets within a database, so we don't need to specify which dataset we're interested in. 

```r
> list_parameter_values(database = "euip", parameter = "decision_stage_id")
Requesting data via the eulaw.app API...
Response received...
# A tibble: 6 x 2
  value label                                
  <int> <chr>                                
1     1 Letter of formal notice (Article 258)
2     2 Reasoned opinion (Article 258)       
3     3 Referral to the Court (Article 258)  
4     4 Letter of formal notice (Article 260)
5     5 Reasoned opinion (Article 260)       
6     6 Referral to the Court (Article 260)  
> 
```

We can see that letters of formal notice are coded `1` and reasoned opinions are coded `2`. When we specify the `parameters` argument, we need to provide a named list where the name of the element is the parameter name. If we want to specify multiple values, we can provide them as a vector.

### Downloading data

We're we ready to download the data. To download directed dyad-year data on letters of formal notice and reasoned opinions since 2010, we can run:

```r
> out <- search_data(
+   database = "euip",
+   dataset = "decisions_ddy",
+   parameters = list(
+     decision_stage_id = c(1, 2)
+   )
+ )
```

The `search_data()` function downloads the data in batches of `10000` observations. It will download `1` batch approximately every `5` seconds. The `eulaw.app` API has a rate limit and this function automatically manages the rate limit for us. The output tells us how many observations we have requested, how many batches it will take to download the data, and approximately how long it will take. The output provides an update every time a batch is download and counts down to the next batch.

And that's it! Now we have a research-ready dataset to use. 
