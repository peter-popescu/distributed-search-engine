require('../distribution.js')();
require('./helpers/sync-guard');
const distribution = globalThis.distribution;

test('(0 pts) local.mem.put append aggregates values', (done) => {
  const key = 'appendkey';

  distribution.local.mem.put(1, {key, action: 'append'}, (e, v) => {
    distribution.local.mem.put(2, {key, action: 'append'}, (e, v) => {
      distribution.local.mem.get(key, (e, v) => {
        try {
          expect(e).toBeFalsy();
          expect(v).toEqual([1, 2]);
          done();
        } catch (error) {
          done(error);
        }
      });
    });
  });
});

test('(0 pts) local.mem.put append adds values to existing list', (done) => {
  const key = 'appendkey';

  distribution.local.mem.put([1], key, (e, v) => {
    distribution.local.mem.put(2, {key, action: 'append'}, (e, v) => {
      distribution.local.mem.get(key, (e, v) => {
        try {
          expect(e).toBeFalsy();
          expect(v).toEqual([1, 2]);
          done();
        } catch (error) {
          done(error);
        }
      });
    });
  });
});

test('(0 pts) local.mem.put append creates list from existing value', (done) => {
  const key = 'appendkey';

  distribution.local.mem.put(1, key, (e, v) => {
    distribution.local.mem.put(2, {key, action: 'append'}, (e, v) => {
      distribution.local.mem.get(key, (e, v) => {
        try {
          expect(e).toBeFalsy();
          expect(v).toEqual([1, 2]);
          done();
        } catch (error) {
          done(error);
        }
      });
    });
  });
});
