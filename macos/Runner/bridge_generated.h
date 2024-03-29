#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
typedef struct _Dart_Handle* Dart_Handle;

typedef struct DartCObject DartCObject;

typedef int64_t DartPort;

typedef bool (*DartPostCObjectFnType)(DartPort port_id, void *message);

typedef struct wire_uint_8_list {
  uint8_t *ptr;
  int32_t len;
} wire_uint_8_list;

typedef struct DartCObject *WireSyncReturn;

void store_dart_post_cobject(DartPostCObjectFnType ptr);

Dart_Handle get_dart_object(uintptr_t ptr);

void drop_dart_object(uintptr_t ptr);

uintptr_t new_dart_opaque(Dart_Handle handle);

intptr_t init_frb_dart_api_dl(void *obj);

void wire_create(int64_t port_, struct wire_uint_8_list *doc_state, bool verbose);

void wire_attest(int64_t port_,
                 struct wire_uint_8_list *did,
                 struct wire_uint_8_list *controlled_did,
                 bool verbose);

void wire_resolve(int64_t port_, struct wire_uint_8_list *did);

void wire_verify(int64_t port_, struct wire_uint_8_list *did);

void wire_vc_sign(int64_t port_,
                  struct wire_uint_8_list *serial_credential,
                  struct wire_uint_8_list *did,
                  struct wire_uint_8_list *key_id);

struct wire_uint_8_list *new_uint_8_list_0(int32_t len);

void free_WireSyncReturn(WireSyncReturn ptr);

static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) wire_create);
    dummy_var ^= ((int64_t) (void*) wire_attest);
    dummy_var ^= ((int64_t) (void*) wire_resolve);
    dummy_var ^= ((int64_t) (void*) wire_verify);
    dummy_var ^= ((int64_t) (void*) wire_vc_sign);
    dummy_var ^= ((int64_t) (void*) new_uint_8_list_0);
    dummy_var ^= ((int64_t) (void*) free_WireSyncReturn);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    dummy_var ^= ((int64_t) (void*) get_dart_object);
    dummy_var ^= ((int64_t) (void*) drop_dart_object);
    dummy_var ^= ((int64_t) (void*) new_dart_opaque);
    return dummy_var;
}
