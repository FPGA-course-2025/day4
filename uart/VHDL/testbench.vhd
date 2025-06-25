library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_tb is
end uart_tb;

architecture sim of uart_tb is

  -- DUT port signals
  signal CLK100MHZ    : std_logic := '0';
  signal uart_txd_in  : std_logic := '1';  -- Idle high
  signal uart_rxd_out : std_logic;

  -- Constants
  constant CLK_PERIOD  : time := 10 ns;                   -- 100 MHz
  constant BAUD_RATE   : integer := 9600;
  constant BAUD_PERIOD : time := 1 sec / BAUD_RATE;       -- ~104.166 us

  -- Component declaration
  component top
    port (
      CLK100MHZ    : in  std_logic;
      uart_txd_in  : in  std_logic;
      uart_rxd_out : out std_logic
    );
  end component;

  -- UART byte sending procedure
  procedure send_uart_byte(
    signal txd  : out std_logic;
    data        : in  std_logic_vector(7 downto 0)
  ) is
  begin
    -- Start bit
    txd <= '0';
    wait for BAUD_PERIOD;

    -- Data bits (LSB first)
    for i in 0 to 7 loop
      txd <= data(i);
      wait for BAUD_PERIOD;
    end loop;

    -- Stop bit
    txd <= '1';
    wait for BAUD_PERIOD;
  end procedure;

begin

  -- Instantiate DUT
  uut: top
    port map (
      CLK100MHZ    => CLK100MHZ,
      uart_txd_in  => uart_txd_in,
      uart_rxd_out => uart_rxd_out
    );

  -- Clock generation
  clk_proc: process
  begin
    while true loop
      CLK100MHZ <= '0';
      wait for CLK_PERIOD / 2;
      CLK100MHZ <= '1';
      wait for CLK_PERIOD / 2;
    end loop;
  end process;

  -- Test sequence
  stim_proc: process
  begin
    wait for 1 ms;

    -- Send UART bytes
    send_uart_byte(uart_txd_in, x"01");  -- Accumulator = 1
    wait for 2 * BAUD_PERIOD;

    send_uart_byte(uart_txd_in, x"02");  -- Accumulator = 3
    wait for 2 * BAUD_PERIOD;

    send_uart_byte(uart_txd_in, x"03");  -- Accumulator = 6
    wait for 2 * BAUD_PERIOD;

    send_uart_byte(uart_txd_in, x"AF");  -- Accumulator = 181
    wait for 2 * BAUD_PERIOD;

    send_uart_byte(uart_txd_in, x"00");  -- Accumulator = 181
    wait for 2 * BAUD_PERIOD;

    wait for 5 ms;
    assert false report "Simulation complete." severity failure;
  end process;

end sim;
