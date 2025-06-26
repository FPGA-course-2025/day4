library ieee;
use ieee.std_logic_1164.all;

entity top is

  port (

    CLK100MHZ    : in  std_logic;
    uart_txd_in  : in  std_logic;
    uart_rxd_out : out std_logic);

end entity top;

architecture str of top is
  signal clock         : std_logic;
  signal data_to_send  : std_logic_vector(7 downto 0) := X"61";
  signal data_received : std_logic_vector(7 downto 0) := X"61";
  signal data_valid_rx : std_logic;
  signal data_valid_tx : std_logic;
  signal busy          : std_logic;
  signal uart_tx       : std_logic;

  component uart_transmitter is
    port (
      clock        : in  std_logic;
      data_to_send : in  std_logic_vector(7 downto 0);
      data_valid   : in  std_logic;
      busy         : out std_logic;
      uart_tx      : out std_logic);
  end component uart_transmitter;

  component uart_receiver is
    port (
      clock         : in  std_logic;
      uart_rx       : in  std_logic;
      valid         : out std_logic;
      received_data : out std_logic_vector(7 downto 0));
  end component uart_receiver;
  
  component accumulator is 
   port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    in_r : IN STD_LOGIC_VECTOR (7 downto 0);
    out_r : OUT STD_LOGIC_VECTOR (7 downto 0);
    out_r_ap_vld : OUT STD_LOGIC );
  end component accumulator;

begin  -- architecture str

  uart_receiver_1 : uart_receiver

    port map (
      clock         => CLK100MHZ,
      uart_rx       => uart_txd_in,
      valid         => data_valid_rx,
      received_data => data_received);
      
  uart_transmitter_1 : uart_transmitter
    port map (
      clock        => CLK100MHZ,
      data_to_send => data_to_send,
      data_valid   => data_valid_tx,
      busy         => busy,
      uart_tx      => uart_rxd_out);

  accumulator_1 : accumulator
    port map(
      ap_clk => CLK100MHZ,
      ap_rst => '0',
      ap_start => data_valid_rx,
      ap_done => data_valid_tx,
      ap_idle => open,
      ap_ready => open,
      in_r => data_received,
      out_r => data_to_send,
      out_r_ap_vld => open
   );
   
end architecture str;
