# Commit Log-Xu





# Controller

## Item

#### Add item

post

URL: /item/insertItem

Input:

| Field Name | Field Type | Validation                                         |
| ---------- | ---------- | -------------------------------------------------- |
| name       | String     | Not Null     Without digits and invalid characters |
| gender     | String     |                                                    |
| age        | int        | Range: 0-150                                       |
| phone      | String     | Only contains digits, "()", "+", "-"               |
| email      | String     | Not Null        Contains ''@'' and "."             |
| message    | String     | Not Null     Less than 2000 characters             |
| file       | Blob       | Max size: 100MB    Max number of files: 20         |
| data       | Json       | Does not include existing fields                   |
| md5        | String     |                                                    |
| token      | String     |                                                    |
| session_id | String     |                                                    |

data:

| Field Name | Field Type | Validation                            |
| ---------- | ---------- | ------------------------------------- |
| v_id       | String     |                                       |
| phone      | String     | Only contains digits, "()", "+", "-"  |
| occupation | String     | Without digits and invalid characters |

Output:

| Field Name | Field Type | Validation |
| ---------- | ---------- | ---------- |
| status     | String     |            |



#### Search result

get

URL: /item/getItemById/{id}

Input:

| Field Name | Field Type | Validation |
| ---------- | ---------- | ---------- |
| i_id       | String     |            |

Output:

| Field Name | Field Type | Validation                                         |
| ---------- | ---------- | -------------------------------------------------- |
| name       | String     | Not Null     Without digits and invalid characters |
| gender     | String     |                                                    |
| age        | int        | Range: 0-150                                       |
| phone      | String     | Only contains digits, "()", "+", "-"               |
| email      | String     | Not Null        Contains ''@'' and "."             |
| message    | String     | Not Null     Less than 2000 characters             |
| file       | Blob       | Max size: 100MB    Max number of files: 20         |
| data       | Json       | Does not include existing fields                   |

data:

| Field Name | Field Type | Validation                            |
| ---------- | ---------- | ------------------------------------- |
| phone      | String     | Only contains digits, "()", "+", "-"  |
| occupation | String     | Without digits and invalid characters |

#### Modify Item

post

URL: /item/modifyItem

Input:

| Field Name | Field Type | Validation                                         |
| ---------- | ---------- | -------------------------------------------------- |
| i_id       | String     |                                                    |
| name       | String     | Not Null     Without digits and invalid characters |
| gender     | String     |                                                    |
| age        | int        | Range: 0-150                                       |
| phone      | String     | Only contains digits, "()", "+", "-"               |
| email      | String     | Not Null        Contains ''@'' and "."             |
| message    | String     | Not Null     Less than 2000 characters             |
| file       | Blob       | Max size: 100MB    Max number of files: 20         |
| data       | Json       | Does not include existing fields                   |

data:



| Field Name | Field Type | Validation                            |
| ---------- | ---------- | ------------------------------------- |
| phone      | String     | Only contains digits, "()", "+", "-"  |
| occupation | String     | Without digits and invalid characters |

Output:

| Field Name | Field Type | Validation |
| ---------- | ---------- | ---------- |
| status     | String     |            |



#### Delete Item

URL: /item/deleteItem

Input:

| Field Name | Field Type | Validation |
| ---------- | ---------- | ---------- |
| i_id       | String     |            |

Output:

| Field Name | Field Type | Validation |
| ---------- | ---------- | ---------- |
| status     | String     |            |



#### Show all results

get

URL: /item/getAllItems

Input:

| Field Name | Field Type | Validation |
| ---------- | ---------- | ---------- |
| v_id       | String     |            |

Output:

| Field Name | Field Type | Validation                                         |
| ---------- | ---------- | -------------------------------------------------- |
| name       | String     | Not Null     Without digits and invalid characters |
| gender     | String     |                                                    |
| age        | int        | Range: 0-150                                       |
| phone      | String     | Only contains digits, "()", "+", "-"               |
| email      | String     | Not Null        Contains ''@'' and "."             |
| message    | String     | Not Null     Less than 2000 characters             |
| file       | Blob       | Max size: 100MB    Max number of files: 20         |
| data       | Json       | Does not include existing fields                   |

data:

| Field Name | Field Type | Validation                            |
| ---------- | ---------- | ------------------------------------- |
| phone      | String     | Only contains digits, "()", "+", "-"  |
| occupation | String     | Without digits and invalid characters |



















## Visitor



### VisitorController1(insert)

post

URL:/visitor/insertVisitor

Input:

| Field Name | Field Type | Validation                                                   |
| ---------- | ---------- | ------------------------------------------------------------ |
| name       | String     | Not Null     Without numbers and invalid characters          |
| gender     | String     | Without numbers                                              |
| age        | int        | Range: 0-150                                                 |
| username   | String     | Not Null,  Unique,  Without special characters               |
| password   | String     | Not Null, at least 8 characters, contains at least one uppercase letters, lowercase letters, numbers and special characters |
| data       | Json       | Does not include existing fields                             |
| md5        | String     |                                                              |
| token      | String     |                                                              |
| session_id | String     |                                                              |

Output:

| Field Name | Field Type | Validation |
| ---------- | ---------- | ---------- |
| status     | String     |            |
|            |            |            |



### VisitorController2(modify)

post

URL:/visitor/modifyVisitor

Input:

| Field Name | Field Type | Validation                                                   |
| ---------- | ---------- | ------------------------------------------------------------ |
| name       | String     | Not Null     Without numbers and invalid characters          |
| gender     | String     | Without numbers                                              |
| age        | int        | Range: 0-150                                                 |
| username   | String     | Not Null,  Unique,  Without special characters               |
| password   | String     | Not Null, at least 8 characters, contains at least one uppercase letters, lowercase letters, numbers and special characters |
| data       | Json       | Does not include existing fields                             |
| md5        | String     |                                                              |
| token      | String     |                                                              |
| session_id | String     |                                                              |

Output:

| Field Name | Field Type | Validation |
| ---------- | ---------- | ---------- |
| status     | String     |            |
|            |            |            |



### VisitorController3(getbyid)

get

URL:/visitor/getVisitorById/{id}

Input:

| Field Name | Field Type | Validation |
| ---------- | ---------- | ---------- |
| v_id       | String     |            |
| md5        | String     |            |
| token      | String     |            |
| session_id | String     |            |

Output:

| Field Name | Field Type | Validation                                                   |
| ---------- | ---------- | ------------------------------------------------------------ |
| name       | String     | Not Null     Without numbers and invalid characters          |
| gender     | String     | Without numbers                                              |
| age        | int        | Range: 0-150                                                 |
| username   | String     | Not Null,  Unique,  Without special characters               |
| password   | String     | Not Null, at least 8 characters, contains at least one uppercase letters, lowercase letters, numbers and special characters |
| data       | Json       | Does not include existing fields                             |



### VisitorController4(delete)

get

URL:/visitor/deleteVisitor/{id}

Input:

| Field Name | Field Type | Validation |
| ---------- | ---------- | ---------- |
| v_id       | String     |            |
| md5        | String     |            |
| token      | String     |            |
| session_id | String     |            |

Output:

| Field Name | Field Type | Validation |
| ---------- | ---------- | ---------- |
| status     | String     |            |





## Customer

### CustomerController1(get)

get

URL:/customer/getCustomer{id}

Input:

| Field Name | Field Type | Validation |
| ---------- | ---------- | ---------- |
| c_id       | String     |            |
| md5        | String     |            |
| token      | String     |            |
| session_id | String     |            |

Output:

| Field Name                   | Field Type | Validation |
| ---------------------------- | ---------- | ---------- |
| name                         | String     |            |
| gender                       | String     |            |
| age                          | int        |            |
| phone                        | String     |            |
| email                        | String     |            |
| biography                    | String     |            |
| interests                    | String     |            |
| work experiences             | String     |            |
| representative work projects |            |            |
| educational background       | String     |            |
| data                         | Json       |            |
|                              |            |            |