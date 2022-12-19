#include <xboot.h>

extern void sys_uart_putc(char c);
extern int sys_uart_printf(const char * fmt, ...);

static void __delay(volatile uint32_t loop)
{
	for(; loop > 0; loop--);
}

static void udelay(uint32_t us)
{
	__delay(us * 2);
}

static void mdelay(uint32_t ms)
{
	udelay(ms * 1000);
}

void xboot_main(void)
{
	int count = 0;

	sys_uart_putc('D');
	sys_uart_putc('1');
	sys_uart_putc(' ');
	sys_uart_putc('b');
	sys_uart_putc('a');
	sys_uart_putc('r');
	sys_uart_putc('e');
	sys_uart_putc('m');
	sys_uart_putc('e');
	sys_uart_putc('t');
	sys_uart_putc('a');
	sys_uart_putc('l');
	sys_uart_putc('\r');
	sys_uart_putc('\n');

	while(1)
	{
		sys_uart_printf("count = %d\r\n", count++);
		mdelay(500);
	}
}
