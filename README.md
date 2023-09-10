## src의 설명
Tools

npx http-server src/

1. RESTful services
2. Data duplication: `1_one`
3. Data Inconsistency: `2_two`
4. How to sync
    1. Single endpoint `3_three`
        1. Some data doesn’t require reload
        2. Dynamically generate composite endpoints
        2. Unless the entire webpage is single endpoint, you still end up with multi-endpoints
    2. Multi endpoint with no duplications
        1. How to post-process
            1. don’t
                1. Make sure that the endpoints don’t interfere with each other (BAD)
                    1. This is hard to track. especially with mutations
                        2. runs and approvals do interfere with each other.
                            1. Because creation of run automatically creates approvals. AND creation of run is triggere by current user.
                        1. group and dataAsset don't interfere with each other
                            1. Creation of provider automatically creates a group, but... That's now possible right now so...
                2. How to detect stale data upon usage
                    1. User find something odd and trigger refresh
                    2. Upon error, refetch before giving up. `4_four`
            2. reload related resource
                1. How to reload `5_five`
                    1. manual refetch (BAD)
                    2. invalidate
                2. How to determine stale resources (BAD)
                    1. using some prefix of a cache key `6_six`
                    2. browser just has to know what the server does.
                        1. Which means when server changes, browsers need to be reviewed
                    3. Maybe the server response will have to url of the stale resource and the hopefully the stale cache key can be derived from the url. `7_seven`
            3. update with server response. `8_eight`
                1. with mutations triggered by self
                2. with reloaded data
                3. Again, you just need to know which resource to update with the given server response.
                    1. Maybe the server response will have to url of the stale resource and the hopefully the stale cache key can be derived from the url. `9_nine`
                4. Apollo (GraphQL Client that does this automatically with type and id)
                    1. Normalized Cache
                    
    
    Winner
    
    1. case by case. It depends on what you value the most.

1. Easy development + good performance `3_three`
    1. Some delay of synchronization is considered acceptable
    2. don’t post-process, let the users trigger refresh if they find something odd.

1. Best UX + good performance `8_eight`
2. 
    1. Delay of synchronization is not acceptable
    2. Update with server response
    3. no unnecessary networks

1. (2) + easy development: `Apollo?`
    1. It’s hard to build the server response… or is it?
    2. Apollo.
        1. But now you have to rely on some black box.
            1. If it never causes issues, good.
            2. If it frequently causes issues, bad.
