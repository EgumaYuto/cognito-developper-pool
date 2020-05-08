import * as AWS from 'aws-sdk';
import * as ARGV from 'argv';

import UserPool from './resource/temp_files/user_pool.json';
import Data from './resource/temp_files/user_data.json';

const init = () => {
    AWS.config.region = 'ap-northeast-1';
};

const args = ARGV.option({
    name: 'confirmation-code',
    short: 'c',
    type: 'string',
    description: 'confirmation code'
}).run();

const getCognitoIdentitySeriviceProvider = () => {
    return new AWS.CognitoIdentityServiceProvider();
};

const main = async () => {
    init();
    const provider = getCognitoIdentitySeriviceProvider();
    await provider.confirmSignUp({
        ClientId: UserPool.app_client_id.value,
        Username: Data.email,
        ConfirmationCode: args.options['confirmation-code']
    }).promise();
};

main();