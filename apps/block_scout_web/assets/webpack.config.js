const path = require('path')
const TerserJSPlugin = require('terser-webpack-plugin')
const MiniCssExtractPlugin = require('mini-css-extract-plugin')
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin')
const CopyWebpackPlugin = require('copy-webpack-plugin')
const { ContextReplacementPlugin } = require('webpack')
const glob = require('glob')

function transpileViewScript(file) {
  return {
    entry: file,
    output: {
      filename: file.replace('./js/view_specific/', ''),
      path: path.resolve(__dirname, '../priv/static/js')
    },
    module: {
      rules: [
        {
          test: /\.js$/,
          exclude: /node_modules/,
          use: {
            loader: 'babel-loader',
            options: {
              presets: ['@babel/preset-env']
            }
          }
        }
      ]
    }
  }
};

const jsOptimizationParams = {
  cache: true,
  parallel: true,
  sourceMap: true
}

const awesompleteJs = {
  entry: {
    awesomplete: './js/lib/awesomplete.js',
    'awesomplete-util': './js/lib/awesomplete-util.js',
  },
  output: {
    filename: '[name].min.js',
    path: path.resolve(__dirname, '../priv/static/js')
  },
  module: {
    rules: [
      {
        test: /\.css$/,
        use: [
          MiniCssExtractPlugin.loader,
          {
            loader: "css-loader",
          }
        ]
      }
    ]
  },
  optimization: {
    minimizer: [
      new TerserJSPlugin(jsOptimizationParams),
    ]
  },
  plugins: [
    new MiniCssExtractPlugin({
      filename: '../css/awesomplete.css'
    })
  ]
}

const appJs =
  {
    entry: {
      app: './js/app.js',
      stakes: './js/pages/stakes.js',
      'chart-loader': './js/chart-loader.js',
      'chain': './js/pages/chain.js',
      'blocks': './js/pages/blocks.js',
      'address': './js/pages/address.js',
      'address-transactions': './js/pages/address/transactions.js',
      'address-coin-balances': './js/pages/address/coin_balances.js',
      'address-internal-transactions': './js/pages/address/internal_transactions.js',
      'address-logs': './js/pages/address/logs.js',
      'address-validations': './js/pages/address/validations.js',
      'validated-transactions': './js/pages/transactions.js',
      'pending-transactions': './js/pages/pending_transactions.js',
      'transaction': './js/pages/transaction.js',
      'non-critical': './css/non-critical.scss'
    },
    output: {
      filename: '[name].js',
      path: path.resolve(__dirname, '../priv/static/js')
    },
    optimization: {
      minimizer: [new TerserJSPlugin(jsOptimizationParams), new OptimizeCSSAssetsPlugin({})],
    },
    module: {
      rules: [
        {
          test: /\.js$/,
          exclude: /node_modules/,
          use: {
            loader: 'babel-loader',
            options: {
              presets: ['@babel/preset-env']
            }
          }
        },
        {
          test: /\.scss$/,
          use: [
            MiniCssExtractPlugin.loader,
            {
              loader: 'css-loader'
            }, {
              loader: 'postcss-loader'
            }, {
              loader: 'sass-loader',
              options: {
                sassOptions: {
                  precision: 8,
                  includePaths: [
                    'node_modules/bootstrap/scss',
                    'node_modules/@fortawesome/fontawesome-free/scss'
                  ]
                }
              }
            }
          ]
        }, {
          test: /\.(svg|ttf|eot|woff|woff2)$/,
          use: {
            loader: 'file-loader',
            options: {
              name: '[name].[ext]',
              outputPath: '../fonts/',
              publicPath: '../fonts/'
            }
          }
        }
      ]
    },
    plugins: [
      new MiniCssExtractPlugin({
        filename: '../css/[name].css'
      }),
      new CopyWebpackPlugin([{ from: 'static/', to: '../' }]),
      new ContextReplacementPlugin(/moment[\/\\]locale$/, /en/)
    ]
  }

const viewScripts = glob.sync('./js/view_specific/**/*.js').map(transpileViewScript)

module.exports = viewScripts.concat(appJs, awesompleteJs)
