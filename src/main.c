#include <stdint.h>

typedef uint8_t bool_t;

extern bool_t cputst_work(void);

void main() {
	bool_t c = cputst_work();

	uint32_t failureCnt = 0;
	if(c == 0) {
		failureCnt++;
	}
}
