import * as AWS from 'aws-sdk';
import * as ARGV from 'argv';

import pool from './resource/temp_files/user_pool.json';
import data from './resource/temp_files/user_data.json';

const args = ARGV.option({
    name: 'profile',
    short: 'p',
    type: 'string',
    description: 'aws profile name'
}).run();

const init = () => {
    AWS.config.credentials = new AWS.SharedIniFileCredentials({
        profile: args.options.profile
    });
    AWS.config.region = 'ap-northeast-1';
};

const getCognitoIdentityServiceProvider = () => {
    return new AWS.CognitoIdentityServiceProvider();
};

const main = async () => {
    init();
    const provider = getCognitoIdentityServiceProvider();
    const {email, password} = data;
    const promiseResult = await provider.signUp({
        ClientId: pool.app_client_id.value,
        Username: email,
        Password: password,
        UserAttributes: [{
            Name: 'email',
            Value: email
        }]
    }).promise().catch(e => {
        console.log(e);
    });
    console.log(promiseResult);
};

main();