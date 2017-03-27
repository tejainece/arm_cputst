#include <stdint.h>

extern uint32_t cputst_work(uint32_t a, uint32_t b);

void main() {
	uint32_t c = cputst_work(5, 5);
	c++;
}
