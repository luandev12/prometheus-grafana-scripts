const express = require('express');
const promClient = require('prom-client');

const app = express();

const REQUEST_COUNT = new promClient.Counter({
  name: 'app_requests_count',
  help: 'Total app HTTP request count',
  labelNames: ['app_name', 'endpoint']
});

const RANDOM_COUNT = new promClient.Counter({
  name: 'app_random_count',
  help: 'Increment counter by random value'
});

const APP_PORT = 8000;
const METRICS_PORT = 8001;

app.get('/', (req, res) => {
  const path = req.url;
  REQUEST_COUNT.labels('prom_express_app', path).inc();

  const randomVal = Math.random() * 10;
  RANDOM_COUNT.inc(randomVal);

  res.send(
    '<html><head><title>First Application</title></head><body style="color: #333; margin-top: 30px;"><center><h2>Welcome to our first Prometheus-Express.js application.</h2></center></body></html>'
  );
});

app.listen(APP_PORT, () => {
  console.log(`Express app started on port ${APP_PORT}`);
});

const metricsApp = express();

metricsApp.get('/metrics', (req, res) => {
  res.set('Content-Type', promClient.register.contentType);
  promClient.register.metrics().then((metrics) => {
    res.end(metrics);
  });
});

metricsApp.listen(METRICS_PORT, () => {
  console.log(`Prometheus server started on port ${METRICS_PORT}`);
});

promClient.collectDefaultMetrics({ register: promClient.register });
