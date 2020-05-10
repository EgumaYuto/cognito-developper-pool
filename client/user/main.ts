import * as AWS from 'aws-sdk';

import UserPool from './resource/temp_files/user_pool.json';
import IdPool from './resource/temp_files/id_pool.json';
import Data from './resource/temp_files/user_data.json';

import 'cross-fetch/polyfill';
import * as  AmazonCognitoIdentity from 'amazon-cognito-identity-js';

const init = () => {
    AWS.config.region = 'ap-northeast-1';
};

const getCognitoIdentitySeriviceProvider = () => {
    return new AWS.CognitoIdentityServiceProvider();
};

const getCognitoIdentity = () => {
    return new AWS.CognitoIdentity();
};

const main = async () => {
    init();
    const identity = getCognitoIdentity();

    // const confilmResult = await getCognitoIdentitySeriviceProvider().confirmSignUp({
    //     ClientId: UserPool.app_client_id.value,
    //     Username: Data.email,
    //     ConfirmationCode: args.options['confirmation-code']
    // }).promise();
    //
    // console.log(confilmResult);

    const authenticationData = {
        Username : Data.email,
        Password : Data.password,
    };
    const authenticationDetails = new AmazonCognitoIdentity.AuthenticationDetails(authenticationData);
    const poolData = {
        UserPoolId: UserPool.user_pool_id.value,
        ClientId: UserPool.app_client_id.value
    };
    const userPool = new AmazonCognitoIdentity.CognitoUserPool(poolData);
    const userData = {
        Username: Data.email,
        Pool: userPool
    };

    const cognitoUser = new AmazonCognitoIdentity.CognitoUser(userData);

    cognitoUser.authenticateUser(authenticationDetails, {
        onSuccess: async result => {
            const idToken = result.getIdToken().getJwtToken();
            await identity.getId({
                IdentityPoolId: IdPool.id_pool_id.value,
                Logins: {
                    "cognito-idp.ap-northeast-1.amazonaws.com/ap-northeast-1_e26PrQEnd": idToken
                }
            }).promise().then(reps => {
                return identity.getCredentialsForIdentity({
                    IdentityId: reps.IdentityId,
                    Logins: {
                        "cognito-idp.ap-northeast-1.amazonaws.com/ap-northeast-1_e26PrQEnd": idToken
                    }
                }).promise();
            }).then(resp => {
                console.log(resp);
            });
        },
        onFailure: err => console.error(err)
    });
};

main();