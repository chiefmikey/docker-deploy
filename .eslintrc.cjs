module.exports = {
  extends: [
    'airbnb-base',
    'plugin:sonarjs/recommended',
    'plugin:compat/recommended',
    'plugin:md/recommended',
    'plugin:css-modules/recommended',
    'plugin:prettier/recommended',
  ],
  overrides: [
    {
      files: ['*.md'],
      parser: 'markdown-eslint-parser',
      rules: {
        'prettier/prettier': ['error', { parser: 'markdown' }],
      },
    },
  ],
  env: {
    browser: true,
    node: true,
    es6: true,
  },
  rules: {
    'no-unused-vars': 'warn',
    'no-console': 'off',
    'func-names': 'off',
    'no-process-exit': 'off',
    'object-shorthand': 'off',
    'class-methods-use-this': 'off',
    'no-underscore-dangle': 'off',
    'import/extensions': 'off',
    'prettier/prettier': ['error'],
    'md/remark': [
      'error',
      {
        plugins: [
          'preset-lint-markdown-style-guide',
          ['lint-emphasis-marker', '_'],
        ],
      },
    ],
  },
  plugins: ['import', 'prettier', 'json-format', 'css-modules'],
  parserOptions: { ecmaVersion: 2020 },
};
